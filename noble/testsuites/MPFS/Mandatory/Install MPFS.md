The scope of this test is to ensure that riscv64+icicle image boots from SD card on Microchip Polarfire Icicle board

<dl>
    <dt>Flash downloaded image onto SD card</dt>
        <dd>You can use Gnome Disks app to restore img.xz onto the SD card</dd>
        <dd> Alternatively you can use xz -d to decompress, and then dd to copy the image to the SD card</dd>
    <dt>Connect networking, serial console to the board</dt>
        <dd>Ethernet cable for networking (both Ethernet connectors work)</dd>
        <dd>USB cable for serial console (board layout here: https://www.microchip.com/content/dam/mchp/documents/FPGA/ProductDocuments/UserGuides/microchip_polarfire_soc_fpga_icicle_kit_user_guide_vb.pdf page 6)</dd>
    <dt>Connect to the 'firmware' serial console</dt>
        <dd>sudo screen /dev/ttyUSB0 115200</dd>
    <dt>Connect to the 'kernel' serial console</dt>
        <dd>sudo screen /dev/ttyUSB1 115200</dd>
    <dt>Power on the board</dt>
        <dd>Power cycling is required here. Pressing the reset button while running the preinstalled SDK does return the board into a bootable state</dd>
        <dd>You should see U-BOOT menu on the firmware console</dd>
        <dd>It should then boot GRUB after a delay</dd>
        <dd>You should see GRUB menu</dd>
        <dd>It should then boot the default kernel after a delay on the kernel serial console</dd>
        <dd>After a while cloud-init will run</dd>
        <dd>Then one will be able to login</dd>
    <dt>Login and change password</dt>
        <dd>Login using ubuntu for both username and password</dd>
        <dd>Reenter ubuntu password again</dd>
        <dd>Set new password</dd>
        <dd>Confirm the new password</dd>
    <dt>Perform generic testing</dt>
        <dd>Check that apt update works</dd>
        <dd>Run any command that is not installed, check that command-not-found recommends things to install</dd>
        <dd>e.g. hello</dd>
        <dd>Install a package and check that it works, e.g. hello</dd>
    <dt>Perform snap testing</dt>
        <dd>Install a snap and check that it works, e.g. hello</dd>
    <dt>Reboot</dt>
        <dd>The board should reboot normally</dd>
    <dt>Poweroff</dt>
        <dd>Console messages should reach poweroff target</dd>
        <dd>There should be final kernel dmsg powering off</dd>
        <dd>Manually turn power-off from the board</dd>
</dl>
<strong>If all actions produce the expected results listed, please <a href="results#add_result">submit</a> a 'passed' result.
    If an action fails, or produces an unexpected result, please <a href="results#add_result">submit</a> a 'failed' result and <a href="../../buginstructions">file a bug</a>. Please be sure to include the bug number when you <a href="results#add_result">submit</a> your result.</strong>


