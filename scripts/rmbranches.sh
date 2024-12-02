#!/usr/bin/env bash

set -e

PROTECTED_BRANCH=main

git branch

for branch in $(git branch | grep -v '\*' | grep -v "$PROTECTED_BRANCH" | awk '{$1=$1; print}'); do
    echo -n "Delete branch "$branch" (y/n)? "
    read ANS
    case "$ANS" in
        y|Y)
            if ! git branch -d "$branch"; then
                echo -n "Force delete branch (y/n)? "
                read ANS
                case "$ANS" in
                    y|Y)
                        git branch -D "$branch"
                        ;;
                    *)
                        :
                esac
            fi
            ;;
        *)
            :
    esac
done
