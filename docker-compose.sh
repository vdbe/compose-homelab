#!/usr/bin/env sh

BASEDIR=$(dirname "$0")

# Default options
DEFAULT_COMPOSE_MODULES="watchtower traefik whoami cloudlare-tunnel"
DEFAULT_ENV_FILE="${BASEDIR}/.env"
DEFAULT_PROJECT_DIR="${BASEDIR}"
DEFAULT_COMPOSE_DIR="${BASEDIR}/docker-compose/"

ENV_FILE="${ENV_FILE:=$DEFAULT_ENV_FILE}"

# Source env file
. "$ENV_FILE"

# Use default options if not already set
COMPOSE_MODULES="${COMPOSE_MODULES:=$DEFAULT_COMPOSE_MODULES}"
PROJECT_DIR="${PROJECT_DIR:=$DEFAULT_PROJECT_DIR}"
COMPOSE_DIR="${COMPOSE_DIR:=$DEFAULT_COMPOSE_DIR}"


# Argument 1: Path to be stripped from trailing slash
# Usage: remove_trailing_slash abcd/
remove_trailing_slash() {
    echo "${1%/}"
}

# Argument 1: Project directory
# Argument 2: Env file
# Argument 2: Compose directory
# Argument 3: Compose modules
# Usage: set ${COMPOSE_MODULES}; compose_files "$PROJECT_DIR" $"ENV_FILE" "$COMPOSE_DIR" $@"
compose_files() {
    compose_dir="${1}"
    shift 1

    for module in "$@"; do
        echo "--file ${compose_dir}/docker-compose.${module}.yaml"
    done;
}

# Argument 1: Project Name
# Argument 1: Project directory
# Argument 2: Env file
# Argument 3: directry containt the docker-compose files
# Argument 4: Array of docker-compose modules
compose_arguments() {
    echo "--project-name ${1}"
    echo "--project-directory ${2}"
    echo "--env-file ${3}"
    shift 3

    compose_files "$@"

}

PROJECT_DIR="$(remove_trailing_slash $PROJECT_DIR)"
COMPOSE_DIR="$(remove_trailing_slash $COMPOSE_DIR)"
PROJECT_NAME="${PROJECT_NAME:=$(basename $(realpath $PROJECT_DIR))}"


user_arguments=$*
set -- $COMPOSE_MODULES;
# Note: Word splitting requried here
docker compose $(compose_arguments "$PROJECT_NAME" "$PROJECT_DIR" "$ENV_FILE" "$COMPOSE_DIR" "$@") $user_arguments

