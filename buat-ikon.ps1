Add-Type -AssemblyName System.Drawing

function New-HuyoIcon([int]$size, [string]$path, [bool]$maskable) {
  $bitmap = New-Object System.Drawing.Bitmap($size, $size)
  $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
  $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $graphics.Clear([System.Drawing.Color]::FromArgb(10, 12, 11))
  $scale = if ($maskable) { 0.72 } else { 0.84 }
  $box = [float]($size * $scale)
  $offset = [float](($size - $box) / 2)
  $gold = [System.Drawing.Color]::FromArgb(216, 173, 62)
  $pale = [System.Drawing.Color]::FromArgb(240, 212, 138)
  $pen = New-Object System.Drawing.Pen($gold, [Math]::Max(2, $size / 128))
  $graphics.DrawRectangle($pen, $offset, $offset, $box, $box)
  $width = [Math]::Max(10, [int]($size / 12))
  $hPen = New-Object System.Drawing.Pen($gold, $width)
  $graphics.DrawLine($hPen, $size*.33, $size*.28, $size*.33, $size*.72)
  $graphics.DrawLine($hPen, $size*.67, $size*.28, $size*.67, $size*.72)
  $graphics.DrawLine($hPen, $size*.33, $size*.5, $size*.67, $size*.5)
  $dotBrush = New-Object System.Drawing.SolidBrush($pale)
  $graphics.FillEllipse($dotBrush, $size*.73, $size*.2, $size*.05, $size*.05)
  $bitmap.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
  $dotBrush.Dispose(); $hPen.Dispose(); $pen.Dispose(); $graphics.Dispose(); $bitmap.Dispose()
}

New-HuyoIcon 192 (Join-Path $PSScriptRoot 'icon-192.png') $false
New-HuyoIcon 512 (Join-Path $PSScriptRoot 'icon-512.png') $false
New-HuyoIcon 512 (Join-Path $PSScriptRoot 'icon-512-maskable.png') $true
