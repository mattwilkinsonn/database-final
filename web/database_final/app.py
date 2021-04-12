# -*- coding: utf-8 -*-
from flask import Flask
from flask import request
app = Flask(__name__)


def some_function(first: int, second: int) -> int:
    """
    We use this function as an example for some real logic.

    This is how you can write a doctest:

    .. code:: python

        >>> some_function(2, 3)
        5

    Enjoy!
    """
    return first + second


@app.route("/")
def hello_world():
    return "Hello, World!"


@app.route("/add_passenger", methods=['POST, GET'])
def add_passenger():
    error = None
    if request.method == 'POST':
        
        


