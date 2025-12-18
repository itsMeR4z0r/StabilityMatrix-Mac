#!/bin/bash

# --- CONFIGURAÇÕES ---
APP_NAME="Stability Matrix.app"
SOURCE_BUILD="build-intel"
EXECUTABLE_NAME="StabilityMatrix.Avalonia"
# Caminho do ícone no código fonte
ICON_SOURCE="StabilityMatrix/Assets/Icon.png" 
# ---------------------

echo "🚀 Gerando $APP_NAME..."

# 1. Limpeza
rm -rf "$APP_NAME"
mkdir -p "$APP_NAME/Contents/MacOS"
mkdir -p "$APP_NAME/Contents/Resources"

# 2. Copiar Binários
echo "📂 Copiando arquivos..."
cp -a "$SOURCE_BUILD/"* "$APP_NAME/Contents/MacOS/"

# 3. Gerar Ícone .icns (O Mac exige isso para exibir o ícone corretamente)
if [ -f "$ICON_SOURCE" ]; then
    echo "🎨 Criando ícone nativo..."
    mkdir StabilityMatrix.iconset
    sips -z 16 16     "$ICON_SOURCE" --out StabilityMatrix.iconset/icon_16x16.png > /dev/null
    sips -z 32 32     "$ICON_SOURCE" --out StabilityMatrix.iconset/icon_16x16@2x.png > /dev/null
    sips -z 32 32     "$ICON_SOURCE" --out StabilityMatrix.iconset/icon_32x32.png > /dev/null
    sips -z 64 64     "$ICON_SOURCE" --out StabilityMatrix.iconset/icon_32x32@2x.png > /dev/null
    sips -z 128 128   "$ICON_SOURCE" --out StabilityMatrix.iconset/icon_128x128.png > /dev/null
    sips -z 256 256   "$ICON_SOURCE" --out StabilityMatrix.iconset/icon_128x128@2x.png > /dev/null
    sips -z 256 256   "$ICON_SOURCE" --out StabilityMatrix.iconset/icon_256x256.png > /dev/null
    sips -z 512 512   "$ICON_SOURCE" --out StabilityMatrix.iconset/icon_256x256@2x.png > /dev/null
    sips -z 512 512   "$ICON_SOURCE" --out StabilityMatrix.iconset/icon_512x512.png > /dev/null
    sips -z 1024 1024 "$ICON_SOURCE" --out StabilityMatrix.iconset/icon_512x512@2x.png > /dev/null
    
    # Converte pasta temporária em arquivo .icns final
    iconutil -c icns StabilityMatrix.iconset
    mv StabilityMatrix.icns "$APP_NAME/Contents/Resources/AppIcon.icns"
    rm -rf StabilityMatrix.iconset
else
    echo "⚠️ Ícone não encontrado em $ICON_SOURCE"
fi

# 4. Criar Info.plist
echo "📝 Configurando Info.plist..."
cat > "$APP_NAME/Contents/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleName</key>
    <string>Stability Matrix</string>
    <key>CFBundleDisplayName</key>
    <string>Stability Matrix</string>
    <key>CFBundleIdentifier</key>
    <string>ai.lykos.stabilitymatrix</string>
    <key>CFBundleVersion</key>
    <string>1.0.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>CFBundleExecutable</key>
    <string>$EXECUTABLE_NAME</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF

# 5. Finalizar
xattr -cr "$APP_NAME"
echo "✅ Sucesso! Mova o 'Stability Matrix.app' para sua pasta de Aplicativos."