import os
import subprocess
import sys

environments = [
    # latest tag == CPython 3.10
    {"NAME": "latest", "PYTHON_VERSION": "3.10"},
    # CPython 3.9
    {"NAME": "python3.9", "PYTHON_VERSION": "3.9"},
    {"NAME": "python3.9-slim", "PYTHON_VERSION": "3.9"},
    {"NAME": "python3.9-alpine", "PYTHON_VERSION": "3.9"},
    {"NAME": "mambaforge3.9", "PYTHON_VERSION": "Mambaforge 3.9"},
    {"NAME": "miniforge3.9", "PYTHON_VERSION": "Miniforge3 3.9"},
    # CPython 3.10
    {"NAME": "python3.10", "PYTHON_VERSION": "3.10"},
    {"NAME": "python3.10-slim", "PYTHON_VERSION": "3.10"},
    {"NAME": "python3.10-alpine", "PYTHON_VERSION": "3.10"},
    {"NAME": "mambaforge3.10", "PYTHON_VERSION": "3.10"},
    {"NAME": "miniforge3.10", "PYTHON_VERSION": "3.10"},
]

start_with = os.environ.get("START_WITH")
build_push = os.environ.get("BUILD_PUSH")


def process_tag(*, env: dict):
    use_env = {**os.environ, **env}
    script = "scripts/test.sh"
    if build_push:
        script = "scripts/build-push.sh"
    return_code = subprocess.call(["bash", script], env=use_env)
    if return_code != 0:
        sys.exit(return_code)


def print_version_envs():
    env_lines = []
    for env in environments:
        env_vars = []
        for key, value in env.items():
            env_vars.append(f"{key}='{value}'")
        env_lines.append(" ".join(env_vars))
    for line in env_lines:
        print(line)


def main():
    start_at = 0
    if start_with:
        start_at = [
            i for i, env in enumerate((environments)) if env["NAME"] == start_with
        ][0]
    for i, env in enumerate(environments[start_at:]):
        print(f"Processing tag: {env['NAME']}")
        process_tag(env=env)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        print_version_envs()
    else:
        main()
