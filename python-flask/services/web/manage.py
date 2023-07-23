from flask.cli import FlaskGroup

from project import server


cli = FlaskGroup(server)


if __name__ == "__main__":
    cli()
