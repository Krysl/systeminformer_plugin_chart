import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:win32/win32.dart';

import '../messages.dart';
import '../utils/logger.dart';

part 'icon.g.dart';

@Riverpod(keepAlive: true)
FutureOr<Uint8List?> getIconPng(
  Ref ref,
  int index, {
  bool isLarge = true,
}) async {
  final icon = await getIconPngData(index, isLarge: isLarge);
  return icon;
}

final Map<int, Uint8List> largeImageCache = {};
final Map<int, Uint8List> smallImageCache = {};

Future<Uint8List?> getIconPngData(int index, {bool isLarge = true}) async {
  final imageCache = isLarge ? largeImageCache : smallImageCache;
  if (imageCache.containsKey(index)) {
    return imageCache[index];
  }

  final SystemInformerHostApi hostApi = SystemInformerHostApi();
  final hBitmap = await hostApi.getImageListIcon(index, isLarge: isLarge);

  final pv = malloc<BITMAP>();
  GetObject(hBitmap, sizeOf<BITMAP>(), pv);
  final bmp = pv.ref;

  final int pixelDataSize = bmp.bmWidthBytes * bmp.bmHeight;
  final bmWidthBytes = bmp.bmWidthBytes;
  logger.d(
    'BMP: ${bmp.bmWidth}x${bmp.bmHeight}\n'
    '\twidthBytes: $bmWidthBytes\n'
    '\t${bmp.bmBitsPixel} bits/pixel\n'
    '\t$pixelDataSize',
  );
  if (bmp.bmBits.address == 0) {
    throw Exception('GetIcons get bmp.bmBits err');
  }
  if (bmp.bmWidth < 0 || bmp.bmWidth > 256) {
    throw Exception('GetIcons err： bmHeight=${bmp.bmHeight}');
  }
  if (bmp.bmHeight < 0 || bmp.bmHeight > 256) {
    throw Exception('GetIcons err： bmHeight=${bmp.bmHeight}');
  }

  final bmpData = bmp.bmBits.cast<Uint8>();
  final bmpBytes = bmpData.asTypedList(pixelDataSize);
  final upsideDown = Uint8List(pixelDataSize);
  for (var i = 0; i < bmp.bmHeight; i++) {
    final start = bmWidthBytes * i;
    final end = start + bmWidthBytes;
    final bRow = Uint8List.sublistView(bmpBytes, start, end);
    upsideDown.setRange(pixelDataSize - end, pixelDataSize - start, bRow);
  }

  final image = img.Image.fromBytes(
    width: bmp.bmWidth,
    height: bmp.bmHeight,
    bytes: upsideDown.buffer,
    numChannels: 4,
    order: img.ChannelOrder.bgra,
  );
  final png = img.encodePng(image);
  imageCache[index] = png;
  return png;
}
