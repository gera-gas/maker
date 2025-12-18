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
@click.argument("input_file", type=click.Path(exists=True))
def process(input_file):
    """Process data file through Maker pipeline."""
    from maker.processing.pipeline import DataLoader

    loader = DataLoader()
    df = loader.load(input_file)

    click.echo(f"Loaded {len(df)} rows, {len(df.columns)} columns")
    click.echo(f"Columns: {', '.join(df.columns)}")
    click.echo(f"First 3 rows:\n{df.head(3)}")


if __name__ == "__main__":
    cli()
