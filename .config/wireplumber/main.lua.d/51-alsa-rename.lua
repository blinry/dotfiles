local renames = {}

renames["alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink"] = "Laptop"
renames["alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink"] = "HDMI 1"
renames["alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_4__sink"] = "HDMI 2"
renames["alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_5__sink"] = "HDMI 3"
renames["alsa_output.usb-Lenovo_ThinkPad_Thunderbolt_4_Dock_USB_Audio_000000000000-00.analog-stereo"] = "Dock"
renames["bluez_output.20_74_CF_EB_43_EC.a2dp-sink"] = "Aeropex"

renames["alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__source"] = "Headset"
renames["alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_6__source"] = "Laptop"

for name,description in pairs(renames) do
  local rule = {
    matches = {
      {
        { "node.name", "equals", name },
      },
    },
    apply_properties = {
      ["node.description"] = description
    },
  }
  table.insert(alsa_monitor.rules,rule)
end

