from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
from dataclasses import dataclass

server = Flask(__name__)
server.config.from_object("project.config.Config")
database = SQLAlchemy(server)


@dataclass
class User(database.Model):
    __tablename__ = "users"
    id: int
    name: str
    email: str

    id = database.Column(database.Integer, primary_key=True)
    name = database.Column(database.Text(), nullable=False)
    email = database.Column(database.Text(), nullable=False)

    def __init__(self, name, email):
        self.name = name
        self.email = email


@server.route("/ping")
def ping():
    return jsonify(answer="Pong!")


@server.route("/users")
def users():
    return jsonify(User.query.all())
