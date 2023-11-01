function getBMP(buffer) {
    const datav = new DataView(buffer);
    const bitmap = {};

    bitmap.fileHeader = {};
    bitmap.fileHeader.bfType = datav.getUint16(0, true);
    bitmap.fileHeader.bfSize = datav.getUint32(2, true);
    bitmap.fileHeader.bfReserved1 = datav.getUint16(6, true);
    bitmap.fileHeader.bfReserved2 = datav.getUint16(8, true);
    bitmap.fileHeader.bfOffBits = datav.getUint32(10, true);
    bitmap.infoHeader = {};
    bitmap.infoHeader.biSize = datav.getUint32(14, true);
    bitmap.infoHeader.biWidth = datav.getUint32(18, true);
    bitmap.infoHeader.biHeight = datav.getUint32(22, true);

    bitmap.infoHeader.biPlanes = datav.getUint16(26, true);
    bitmap.infoHeader.biBitCount = datav.getUint16(28, true);
    bitmap.infoHeader.biCompression = datav.getUint32(30, true);
    bitmap.infoHeader.biSizeImage = datav.getUint32(34, true);
    bitmap.infoHeader.biXPelsPerMeter = datav.getUint32(38, true);
    bitmap.infoHeader.biYPelsPerMeter = datav.getUint32(42, true);
    bitmap.infoHeader.biClrUsed = datav.getUint32(46, true);
    bitmap.infoHeader.biClrImportant = datav.getUint32(50, true);

    bitmap.rowSize = Math.floor((bitmap.infoHeader.biBitCount * bitmap.infoHeader.biWidth + 31) / 32) * 4;
    const start = bitmap.fileHeader.bfOffBits;
    bitmap.pixelArray = new Uint8Array(buffer, start);

    return bitmap;
}

function convertToImageData(bitmap) {
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');
    const width = bitmap.infoHeader.biWidth;
    const height = bitmap.infoHeader.biHeight;
    const imageData = ctx.createImageData(width, height);

    let data = imageData.data;
    let bmpdata = bitmap.pixelArray;
    let rowSize = bitmap.rowSize;

    for (let y = 0; y < height; ++y) {
        let bmpOffset = y * rowSize;
        let dataOffset = y * width * 4;
        for (let x = 0; x < width; ++x) {
            data[dataOffset++] = bmpdata[bmpOffset + 2];
            data[dataOffset++] = bmpdata[bmpOffset + 1];
            data[dataOffset++] = bmpdata[bmpOffset];
            data[dataOffset++] = 255;
            bmpOffset += 3;
        }
    }

    return imageData;
}