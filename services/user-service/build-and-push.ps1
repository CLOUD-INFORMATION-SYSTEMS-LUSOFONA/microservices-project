# build-and-push.ps1

# Configurações
$IMAGE_NAME = "miguelrodr1gues/user-service"

# Recebe a versão como argumento, default = latest
if ($args.Count -gt 0) {
    $VERSION = $args[0]
} else {
    $VERSION = "latest"
}

# Obtém o commit curto atual do Git e remove espaços/quebras de linha
$GIT_COMMIT = (git rev-parse --short HEAD).Trim()

Write-Host "---" -ForegroundColor Gray
Write-Host "Building Docker images for $IMAGE_NAME" -ForegroundColor Cyan
Write-Host "Version tag: $VERSION"
Write-Host "Git commit tag: $GIT_COMMIT"
Write-Host "---" -ForegroundColor Gray

# Build da imagem com tag de versão
docker build -t "${IMAGE_NAME}:${VERSION}" .

# Build da imagem com tag de commit
docker build -t "${IMAGE_NAME}:${GIT_COMMIT}" .

Write-Host "`nPushing Docker images to Docker Hub..." -ForegroundColor Green

# Push da imagem com tag de versão
docker push "${IMAGE_NAME}:${VERSION}"

# Push da imagem com tag de commit
docker push "${IMAGE_NAME}:${GIT_COMMIT}"

Write-Host "`nConcluído com sucesso!" -ForegroundColor Yellow