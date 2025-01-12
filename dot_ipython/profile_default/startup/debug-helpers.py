class helpers:
    def dir(obj, dunder=True):
        data = {
            attr: getattr(obj, attr)
            for attr in dir(obj)
            if dunder or attr.startswith('__')
        }
        # Ignore a couple keys that are usually unwanted
        for key in ('__builtins__',):
            if key in data:
                data[key] = ...
        return data
