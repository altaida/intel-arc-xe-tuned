#!/bin/bash

# Intel Arc A770 Complete Setup with Frame Generation
# Полная установка с поддержкой генерации кадров

echo "=== Intel Arc A770 Complete Optimization Installation ==="

if [[ $EUID -ne 0 ]]; then
    echo "This script requires sudo privileges"
    exit 1
fi

echo "Step 1: Installing dependencies..."
pacman -S --noconfirm base-devel linux-headers git cmake python python-pip
pacman -S --noconfirm mesa lib32-mesa vulkan-intel lib32-vulkan-intel
pacman -S --noconfirm level-zero level-zero-loader intel-level-zero-gpu
pacman -S --noconfirm mangohud gputop intel-gpu-tools
pacman -S --noconfirm steam proton

echo "Step 2: Applying kernel configurations..."
if [ -f config/modprobe-arc.conf ]; then
    cp config/modprobe-arc.conf /etc/modprobe.d/intel-arc.conf
fi

if [ -f config/sysctl-optimization.conf ]; then
    cp config/sysctl-optimization.conf /etc/sysctl.d/99-intel-arc.conf
    sysctl -p /etc/sysctl.d/99-intel-arc.conf
fi

if [ -f config/udev-rules.conf ]; then
    cp config/udev-rules.conf /etc/udev/rules.d/99-intel-arc.rules
    udevadm control --reload
fi

echo "Step 3: Setting up optimization scripts..."
chmod +x tuning/*.sh
chmod +x setup.sh
chmod +x test-performance.sh

echo "Step 4: Installing MangoHUD configuration..."
mkdir -p /root/.config/MangoHUD
cp mangohud/gaming.conf /root/.config/MangoHUD/MangoHUD.conf

echo "Step 5: Creating symbolic links..."
ln -sf $(pwd)/tuning/*.sh /usr/local/bin/ 2>/dev/null || true

echo ""
echo "✓ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Reboot: sudo reboot"
echo "2. Test system: ./setup.sh check"
echo "3. Enable Frame Generation: ./tuning/frame-generation.sh enable"
echo "4. Launch game: ./tuning/game-optimization-complete.sh balanced"
echo ""
echo "Frame Generation Features:"
echo "  - Single generation (1 frame)"
echo "  - Multi-generation (2-3 frames)"
echo "  - Deep Frame Synthesis (AI-powered)"
echo "  - Frame Interpolation (1x to 4x)"
echo ""
