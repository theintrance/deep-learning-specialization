#!/bin/bash

set -e

PUBLIC_PATH="astro/public"
KO_DOCS_PATH="astro/src/content/docs/ko"
CONSTS_PATH="astro/src/consts.ts"

rm -rf $KO_DOCS_PATH
mkdir -p $KO_DOCS_PATH

# copy README.md to introduction.md
cp README.md $KO_DOCS_PATH/introduction.md

# copy assets to public
cp -r assets $PUBLIC_PATH

# remove current sidebar consts
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' '/export const SIDEBAR: Sidebar = {/,/^}/d' $CONSTS_PATH
else
    sed -i '/export const SIDEBAR: Sidebar = {/,/^}/d' $CONSTS_PATH
fi

# copy chapters to ko/chapter
chapters=$(find . -maxdepth 1 -type d -name '[0-9]_*' | sort -V)
for chapter in $chapters; do
    mkdir -p "$KO_DOCS_PATH/$chapter"
    cp -r "$chapter" "$KO_DOCS_PATH"
done

# add sidebar consts
echo "export const SIDEBAR: Sidebar = {" | tee -a $CONSTS_PATH
echo "  ko: {" | tee -a $CONSTS_PATH
i=1
for chapter in $chapters; do
    header=$(basename "${chapter/[0-9]_/}")
    header=${header//_/ }
    echo "    '$header': {" | tee -a $CONSTS_PATH
    
    j=1
    sub_chapters=$(find "$chapter" -maxdepth 1 -type d -name '[0-9][0-9]_*' | sort -V)
    for sub_chapter in $sub_chapters; do
        sub_header=$(basename "${sub_chapter/[0-9][0-9]_/}")
        sub_header=${sub_header//_/ }
        echo "      '$sub_header': [" | tee -a $CONSTS_PATH
        
        k=1
        contents=$(find "$sub_chapter" -maxdepth 1 -type f -name '*.mdx' | sort -V)
        for content in $contents; do
            content=${content/.mdx/}
            content=${content#./}
            content_name=$(basename "${content/ko\//}")
            
            content_name=${content_name//[0-9][0-9]_/}
            content_name=${content_name//_/ }

            # make index like: 1.2.2
            index="$i.$j.$k"
            content_name="$index. $content_name"

            # lowercase "content"
            content=$(echo "$content" | tr '[:upper:]' '[:lower:]')

            # remove ( and ) from content
            content=${content//\(/}
            content=${content//\)/}
    
            echo "        { text: '$content_name', link: '/ko/$content' }," | tee -a $CONSTS_PATH
            k=$((k+1))
        done
        echo "      ]," | tee -a $CONSTS_PATH
        j=$((j+1))
    done
    echo "    }," | tee -a $CONSTS_PATH
    i=$((i+1))
done
echo "  }" | tee -a $CONSTS_PATH
echo "};" | tee -a $CONSTS_PATH

# replace ![](/assets/...) to ![](assets/...)
if [[ "$OSTYPE" == "darwin"* ]]; then
    find $KO_DOCS_PATH -type f -name '*.mdx' -exec sed -i '' 's/!\[\](\/assets/!\[\](assets/g' {} +
else
    find $KO_DOCS_PATH -type f -name '*.mdx' -exec sed -i 's/!\[\](\/assets/!\[\](assets/g' {} +
fi
