"""Exercise installer behavior against disposable project directories."""
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


class InstallerTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.project = Path(self.temp.name) / 'backend project'

    def install(self, ok=True):
        result = subprocess.run(['bash', str(ROOT / 'install.sh'), str(self.project)],
                                capture_output=True, text=True)
        self.assertEqual(result.returncode == 0, ok, result.stdout + result.stderr)
        return result

    def snapshot(self):
        return {str(p.relative_to(self.project)): p.read_bytes()
                for p in self.project.rglob('*') if p.is_file()}

    def test_fresh_install_and_repeat(self):
        self.install()
        expected = {str(p.relative_to(ROOT / 'template')): p.read_bytes()
                    for p in (ROOT / 'template').rglob('*') if p.is_file()}
        self.assertEqual(self.snapshot(), expected)
        self.install()
        self.assertEqual(self.snapshot(), expected)

    def test_preserves_existing_instructions_and_state(self):
        (self.project / '.agent').mkdir(parents=True)
        for name in ['CLAUDE.md', 'AGENTS.md', '.agent/TASKS.md', '.agent/WORKFLOW.md']:
            (self.project / name).write_text('existing project content: ' + name)
        original = self.snapshot()
        self.install()
        after = self.snapshot()
        for name, content in original.items():
            self.assertEqual(after[name], content)
        self.assertTrue((self.project / '.agent/architecture.md').is_file())

    def test_conflicting_directory_is_rejected_before_copy(self):
        (self.project / '.agent').mkdir(parents=True)
        (self.project / '.agent/specs').write_text('keep me')
        before = self.snapshot()
        self.install(ok=False)
        self.assertEqual(self.snapshot(), before)

    def test_symlink_is_rejected_without_modifying_external_file(self):
        self.project.mkdir()
        outside = Path(self.temp.name) / 'outside'
        outside.write_text('keep me')
        (self.project / 'CLAUDE.md').symlink_to(outside)
        self.install(ok=False)
        self.assertEqual(outside.read_text(), 'keep me')
        self.assertFalse((self.project / '.agent').exists())

    def test_symlink_state_directory_is_rejected(self):
        self.project.mkdir()
        outside = Path(self.temp.name) / 'outside'
        outside.mkdir()
        (self.project / '.agent').symlink_to(outside, target_is_directory=True)
        self.install(ok=False)
        self.assertEqual(list(outside.iterdir()), [])


if __name__ == '__main__':
    unittest.main()
