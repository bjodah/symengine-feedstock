#!/usr/bin/env bash

# PLEASE NOTE: This script has been automatically generated by conda-smithy. Any changes here
# will be lost next time ``conda smithy rerender`` is run. If you would like to make permanent
# changes to this script, consider a proposal to conda-smithy so that other feedstocks can also
# benefit from the improvement.

FEEDSTOCK_ROOT=$(cd "$(dirname "$0")/.."; pwd;)
RECIPE_ROOT=$FEEDSTOCK_ROOT/recipe

docker info

config=$(cat <<CONDARC

channels:
 - conda-forge
 - symengine
 - defaults # As we need conda-build

conda-build:
 root-dir: /feedstock_root/build_artefacts

show_channel_urls: true

CONDARC
)

cat << EOF | docker run -i \
                        -v ${RECIPE_ROOT}:/recipe_root \
                        -v ${FEEDSTOCK_ROOT}:/feedstock_root \
                        -a stdin -a stdout -a stderr \
                        condaforge/linux-anvil \
                        bash || exit $?

export BINSTAR_TOKEN=${BINSTAR_TOKEN}
export PYTHONUNBUFFERED=1

echo "$config" > ~/.condarc
# A lock sometimes occurs with incomplete builds. The lock file is stored in build_artefacts.
conda clean --lock

conda update --yes --all
conda install --yes conda-build
conda info

# Embarking on 1 case(s).
    conda build /recipe_root --quiet || exit 1
    /feedstock_root/ci_support/upload_or_check_non_existence.py /recipe_root symengine --channel=main || exit 1
EOF
