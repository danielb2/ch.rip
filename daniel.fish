function mkaudio
    set -l file $argv[1]
    set -l dirname (path basename -E $file)
    mkdir $dirname
    mv $file $dirname
end

for i in */
    node repack.js "$i"
end

for i in *Written*.m4a
    set -l new (string replace -r '^(.*?)\s-\s*Written by\s*(.*) - Narrated.*$' '$2 - $1' $i)
    mv -i "$i" "$new.m4b"
end

mkdir complete
mv *m4b complete/
cd complete/

for i in *m4b
    mkaudio "$i"
end
