# Rpa

rpa is Ruby Photo Album (Generator). It generates simple html photo albums.

Current theme uses Galleriffic (http://www.twospy.com/galleriffic/)

## Installation

$ gem install rpa

## Usage

```
$ rpa -h
Usage: $ rpa [options]

rpa is Ruby Photo Album (Generator)

Default values:
        in_dir = /home/atongen/Workspace/personal/rpa
        verbose = false
        title = Ruby Photo Album
        theme = galleriffic
        list_themes = false

Options:
    -o, --out-dir [OUT_DIR]
    -i, --in-dir [IN_DIR]
    -v, --[no-]verbose
    -t, --title [TITLE]
    -s, --subtitle [SUBTITLE]
        --theme [THEME]
    -l, --[no-]list                  list themes
        --help
```

## Why?

This was a single-file script that I wrote a while ago and then
forgot about. I needed to use it recently, so I thought I'd
gemify and publish it.

## Contributing

1. Fork it ( http://github.com/andrew/rpa/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
