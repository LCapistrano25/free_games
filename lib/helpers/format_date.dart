String formatarData(String dataIso) {
  try {
    final partes = dataIso.split('-');
    if (partes.length != 3) return dataIso;

    final ano = partes[0];
    final mes = partes[1];
    final dia = partes[2];

    return '$dia/$mes/$ano';
  } catch (_) {
    return dataIso;
  }
}
