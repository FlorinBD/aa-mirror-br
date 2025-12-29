AA_MIRROR_RS_VERSION = main
AA_MIRROR_RS_SITE = https://github.com/FlorinBD/aa-mirror-rs.git
AA_MIRROR_RS_SITE_METHOD = git

# obtain git hashes for aa-mirror-rs and buildroot
BUILDROOT_DIR = $(realpath $(TOPDIR)/..)
BUILDROOT_COMMIT = $(shell git config --global --add safe.directory $(BUILDROOT_DIR) && git -C $(BUILDROOT_DIR) rev-parse HEAD)
AA_MIRROR_RS_GIT_DIR = $(realpath $(DL_DIR)/aa-mirror-rs/git)
AA_MIRROR_RS_COMMIT = $(shell git config --global --add safe.directory $(AA_MIRROR_RS_GIT_DIR) && git -C $(AA_MIRROR_RS_GIT_DIR) rev-parse HEAD)

define AA_MIRROR_RS_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/target/$(RUSTC_TARGET_NAME)/release/aa-mirror-rs $(TARGET_DIR)/usr/bin
    $(INSTALL) -D -m 0644 $(@D)/target/release/config.toml $(TARGET_DIR)/etc/aa-mirror-rs/config.toml
    $(INSTALL) -D -m 0755 $(@D)/contrib/S93aa-mirror-rs $(TARGET_DIR)/etc/init.d
    #copy RES files
    $(INSTALL) -D -m 0644 $(@D)/images/AndroidIcon32.png $(TARGET_DIR)/etc/aa-mirror-rs/res/AndroidIcon32.png
    $(INSTALL) -D -m 0644 $(@D)/images/AndroidIcon64.png $(TARGET_DIR)/etc/aa-mirror-rs/res/AndroidIcon64.png
    $(INSTALL) -D -m 0644 $(@D)/images/AndroidIcon128.png $(TARGET_DIR)/etc/aa-mirror-rs/res/AndroidIcon128.png
    $(INSTALL) -D -m 0644 $(@D)/images/130dpi.png $(TARGET_DIR)/etc/aa-mirror-rs/res/130dpi.png
    $(INSTALL) -D -m 0644 $(@D)/images/160dpi.png $(TARGET_DIR)/etc/aa-mirror-rs/res/160dpi.png
    $(INSTALL) -D -m 0644 $(@D)/contrib/scrcpy-server $(TARGET_DIR)/etc/aa-mirror-rs/scrcpy-server
endef

# pass git hashes as env variables
AA_MIRROR_RS_CARGO_ENV = \
    AA_MIRROR_COMMIT="$(AA_MIRROR_RS_COMMIT)" \
    BUILDROOT_COMMIT="$(BUILDROOT_COMMIT)"

# default config file generator
define AA_MIRROR_RS_GENERATE_CONFIG
    cd $(@D) && env PATH=$${PATH}:$(HOST_DIR)/bin cargo run --release --bin generate_config
endef
AA_MIRROR_RS_POST_BUILD_HOOKS += AA_MIRROR_RS_GENERATE_CONFIG

$(eval $(cargo-package))

