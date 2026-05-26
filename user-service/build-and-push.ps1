# build-and-push.ps1
# Script para construir e enviar Docker image no Windows PowerShell

$IMAGE_NAME = "miguelrodr1gues/user-service"

# Recebe a versão como argumento, default = latest
$VERSION = if ($args[0]) { $args[0] } else { "latest" }

# Obtém o commit curto atual do Git
$GIT_COMMIT = git rev-parse --short HEAD

Write-Host "🚀 Building Docker images for $IMAGE_NAME" -ForegroundColor Cyan
Write-Host "Version tag: $VERSION"
Write-Host "Git commit tag: $GIT_COMMIT"

# Build da imagem com tag de versão
docker build -t "${IMAGE_NAME}:${VERSION}" .

# Build da imagem com tag de commit
docker build -t "${IMAGE_NAME}:${GIT_COMMIT}" .

Write-Host "🔹 Pushing Docker images to Docker Hub" -ForegroundColor Green

# Push da imagem com tag de versão
docker push "${IMAGE_NAME}:${VERSION}"

# Push da imagem com tag de commit
docker push "${IMAGE_NAME}:${GIT_COMMIT}"