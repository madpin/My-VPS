#!/usr/bin/env bash

DC_BOOKS=./docker/books/docker-compose.yml
DC_CODE=./docker/code/docker-compose.yml
DC_JUPYTER=./docker/jupyter/docker-compose.yml
DC_MONITOR=./docker/monitor/docker-compose.yml
DC_PROXY=./docker/proxy/docker-compose.yml
DC_SCROBBLER=./docker/scrobbler/docker-compose.yml
DC_WEBSITE=./docker/website/docker-compose.yml

function all_down() {
    docker-compose -f $DC_SCROBBLER down & PID_SCROBBLER=$!
    docker-compose -f $DC_BOOKS down & PID_BOOKS=$!
    docker-compose -f $DC_CODE down & PID_CODE=$!
    docker-compose -f $DC_JUPYTER down & PID_JUPYTER=$!
    docker-compose -f $DC_MONITOR down & PID_MONITOR=$!
    docker-compose -f $DC_PROXY down & PID_PROXY=$!
    docker-compose -f $DC_WEBSITE down & PID_WEBSITE=$!

    wait $PID_SCROBBLER
    wait $PID_BOOKS
    wait $PID_CODE
    wait $PID_JUPYTER
    wait $PID_MONITOR
    wait $PID_PROXY
    wait $PID_WEBSITE
}

function docker_pulls() {
    docker-compose -f $DC_SCROBBLER pull & PID_SCROBBLER=$!
    docker-compose -f $DC_BOOKS pull & PID_BOOKS=$!
    docker-compose -f $DC_CODE pull & PID_CODE=$!
    docker-compose -f $DC_JUPYTER pull & PID_JUPYTER=$!
    docker-compose -f $DC_MONITOR pull & PID_MONITOR=$!
    docker-compose -f $DC_PROXY pull & PID_PROXY=$!
    docker-compose -f $DC_WEBSITE pull & PID_WEBSITE=$!

    wait $PID_SCROBBLER
    wait $PID_BOOKS
    wait $PID_CODE
    wait $PID_JUPYTER
    wait $PID_MONITOR
    wait $PID_PROXY
    wait $PID_WEBSITE

}

function docker_image_prune() {
    # docker image prune -f # This also prune Networks
    # docker network prune -f
    # docker volume prune -f

    docker builder prune -f # Build Cache
    docker container prune -f
    docker image prune -f
}

function all_up() {

    # docker-compose -f $DC_PROXY up -d
    # docker-compose -f $DC_BOOKS up -d
    # docker-compose -f $DC_CODE up -d
    # docker-compose -f $DC_JUPYTER up -d
    # docker-compose -f $DC_MONITOR up -d
    # docker-compose -f $DC_WEBSITE up -d
    # scrob_watch

    docker-compose -f $DC_BOOKS up -d & PID_BOOKS=$!
    docker-compose -f $DC_CODE up -d & PID_CODE=$!
    docker-compose -f $DC_JUPYTER up -d & PID_JUPYTER=$!
    docker-compose -f $DC_MONITOR up -d & PID_MONITOR=$!
    docker-compose -f $DC_PROXY up -d & PID_PROXY=$!
    docker-compose -f $DC_WEBSITE up -d & PID_WEBSITE=$!

    wait $PID_SCROBBLER
    wait $PID_BOOKS
    wait $PID_CODE
    wait $PID_JUPYTER
    wait $PID_MONITOR
    wait $PID_PROXY
    wait $PID_WEBSITE
    
    scrob_watch
}

function scrob_watch() {
    docker-compose -f $DC_SCROBBLER down
    docker-compose -f $DC_SCROBBLER run --name scrobbler_watch --rm -d plextraktsync watch
}
function scrob_sync() {
    docker-compose -f $DC_SCROBBLER run --rm plextraktsync
}
function scrob_relogin() {
    docker-compose -f $DC_SCROBBLER run plextraktsync login
    docker-compose -f $DC_SCROBBLER run plextraktsync plex-login
}