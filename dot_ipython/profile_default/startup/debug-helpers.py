class helpers:
    def dir(obj: object, dunder: bool = True):
        ignore_list = {'__builtins__'}
        data {
            attr: getattr(obj, attr)
            for attr in dir(obj)
            if dunder or attr.startswith('__')
        }
        data |= {key: ... for key in data.keys() & ignore_list}
        return data
