import importlib


_IPYTHON_AUTO_IMPORT_MODULES = [
    'abc',
    'argparse',
    'asyncio',
    'ast',
    'atexit',
    'builtins',
    'code',
    'codeop',
    'collections',
    'collections.abc',
    'compileall',
    'concurrent',
    'concurrent.futures',
    'configparser',
    'contextlib',
    'cProfile',
    'csv',
    'ctypes',
    'dataclasses',
    'datetime',
    'difflib',
    'dis',
    'email',
    'ensurepip',
    'errno',
    'faulthandler',
    'filecmp',
    'fcntl',
    'functools',
    'gc',
    'gettext',
    'glob',
    'hashlib',
    'importlib',
    'importlib.machinery',
    'importlib.metadata',
    'importlib.resources',
    'importlib.resources.abc',
    'importlib.util',
    'inspect',
    'io',
    'itertools',
    'json',
    'locale',
    'logging',
    'marshal',
    'multiprocessing',
    'operator',
    'optparse',
    'os',
    'pathlib',
    'pdb',
    'pickle',
    'pickletools',
    'platform',
    'posix',
    'pprint',
    'profile',
    'py_compile',
    'pydoc',
    'runpy',
    'select',
    'selectors',
    'signal',
    'site',
    'shelve',
    'shlex',
    'shutil',
    'socket',
    'subprocess',
    'symtable',
    'sys',
    'sysconfig',
    'warnings',
    'tarfile',
    'tempfile',
    'trace',
    'traceback',
    'tracemalloc',
    'test',
    'test.support',
    'test.support.bytecode_helper',
    'test.support.import_helper',
    'test.support.os_helper',
    'test.support.script_helper',
    'test.support.socket_helper',
    'test.support.warnings_helper',
    'test.support.threading_helper',
    'textwrap',
    'threading',
    'time',
    'timeit',
    'tokenize',
    'tomllib',
    'types',
    'typing',
    'unittest',
    'unittest.mock',
    'urllib',
    'urllib.request',
    'urllib.response',
    'urllib.parse',
    'urllib.error',
    'uuid',
    'venv',
    'zipapp',
    'zipimport',
    'zipfile',
]

for name in _IPYTHON_AUTO_IMPORT_MODULES:
    locals()[name] = importlib.import_module(name)