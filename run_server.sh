cd web
poetry config virtualenvs.create false --local
poetry install
cd database_final
flask run