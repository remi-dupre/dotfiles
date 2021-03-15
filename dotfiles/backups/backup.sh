#!/bin/bash
user=remi
root=/home/$user/backups
dest=data


if [[ $1 = create ]] ; then
    mkdir -p $root/$dest

    suffix=`date --rfc-3339=date`

    nth=1
    while [ -e $root/$dest/$suffix.$nth.tar.gz.gpg ] ; do
        nth=$((nth+1))
    done

    file=$root/$dest/$suffix.$nth.tar.gz.gpg
    create_backup=(
        tar --create --to-stdout --gzip
            --exclude-from=$root/excludes
            --exclude-backups
            --exclude-caches-all
            --exclude-vcs-ignores
            --exclude-tag-all=.no-backup
            --files-from=$root/targets
            --listed-incremental=$root/$dest/incremential.list
    )
    "${create_backup[@]}" | gpg --recipient $user --encrypt > $file
fi


if [[ $1 = extract ]] ; then
    mkdir -p $root/extracted

    for file in $root/$dest/*.tar.gz.gpg ; do
        echo $file
        extract_backup=(
            tar --extract --gzip
                --listed-incremental=/dev/null
                --directory=$root/extracted
        )
        gpg --decrypt $file | "${extract_backup[@]}"
    done
fi

