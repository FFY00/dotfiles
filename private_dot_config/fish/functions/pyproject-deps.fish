function pyproject-deps
	tomlq -r '(.project.dependencies + .project."optional-dependencies"[])[]' pyproject.toml
end
