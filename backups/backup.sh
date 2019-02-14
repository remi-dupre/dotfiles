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

    file=$root/$dest/$suffix.$nth.tar.gz
    create_backup=(
        tar --create --file=$file
            --files-from=$root/targets
            --listed-incremental=$root/$dest/incremential.list
            --gzip
    )
    "${create_backup[@]}"
    gpg --recipient $user --encrypt $file
    rm $file
fi


if [[ $1 = extract ]] ; then
    mkdir -p $root/extracted

    for file in $root/$dest/*.tar.gz.gpg ; do
        echo $file
        gpg --output temp.tar.gz --decrypt $file
        extract_backup=(
            tar --extract
                --listed-incremental=/dev/null
                --file temp.tar.gz
                --directory=$root/extracted
        )
        "${extract_backup[@]}"
        rm temp.tar.gz
    done
fi

