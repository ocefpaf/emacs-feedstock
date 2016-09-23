if [ "$(uname)" == "Darwin" ]; then
    OPTS="--disable-ns-self-contained"
else
    OPTS="--x-includes=$PREFIX/include --x-libraries=$PREFIX/lib"
fi

bash configure  --prefix=$PREFIX $OPTS

make
make check
make install

if [ "$(uname)" == "Darwin" ]; then
    # Based on
    # https://github.com/Homebrew/homebrew-core/blob/master/Formula/emacs.rb
    mv nextstep/Emacs.app $PREFIX/Emacs.app
    mkdir -p $PREFIX/bin
    rm $PREFIX/bin/emacs
    cat <<EOF > $PREFIX/bin/emacs
#!/bin/bash
exec $PREFIX/Emacs.app/Contents/MacOS/Emacs "$@"
EOF

fi
