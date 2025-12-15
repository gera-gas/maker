from click.testing import CliRunner

from maker.cli import cli


def test_version():
    runner = CliRunner()
    result = runner.invoke(cli, ["version"])
    assert result.exit_code == 0
    assert "maker 0.1.0" in result.output
