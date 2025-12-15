"""Main CLI for Maker"""
import click


@click.group()
def cli():
    """Maker - AI-powered project generator"""
    pass


@cli.command()
def version():
    """Show version"""
    click.echo("maker 0.1.0")


@cli.command()
@click.argument("name")
def hello(name: str):
    """Say hello"""
    click.echo(f"Hello, {name}! Maker is ready.")


if __name__ == "__main__":
    cli()
