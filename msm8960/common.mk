#Common headers
common_includes := hardware/qcom/display/msm8960/libgralloc
common_includes += hardware/qcom/display/msm8960/liboverlay
common_includes += hardware/qcom/display/msm8960/libcopybit
common_includes += hardware/qcom/display/msm8960/libqdutils
common_includes += hardware/qcom/display/msm8960/libhwcomposer
common_includes += hardware/qcom/display/msm8960/libexternal
common_includes += hardware/qcom/display/msm8960/libqservice

common_header_export_path := qcom/display

#Common libraries external to display HAL
common_libs := liblog libutils libcutils libhardware

#Common C flags
common_flags := -DDEBUG_CALC_FPS -Wno-missing-field-initializers
common_flags += -Werror -Wno-unused-parameter

ifeq ($(ARCH_ARM_HAVE_NEON),true)
    common_flags += -D__ARM_HAVE_NEON
endif

ifneq ($(filter msm8974 msm8x74 msm8226 msm8x26,$(TARGET_BOARD_PLATFORM)),)
    common_flags += -DVENUS_COLOR_FORMAT
    common_flags += -DMDSS_TARGET
endif

common_deps  :=
kernel_includes :=

# Executed only on QCOM BSPs
# Explicitly exclude mako, since CM adds the QCOM make functions and triggers
# this block incorrectly
ifeq ($(TARGET_QCOM_OLD_BSP),)
ifeq ($(filter mako occam,$(TARGET_DEVICE)),)
    common_flags += -DQCOM_BSP
endif
endif
ifeq ($(call is-vendor-board-platform,QCOM),true)
ifeq ($(TARGET_PREBUILT_KERNEL,KERNEL_BIN),false)
    common_deps += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
    kernel_includes += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
endif
endif
