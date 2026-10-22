import 'dart:io';
import 'dart:math';

void main() {
  final aplicacion = AplicacionEjercicios([
    PotenciaPositiva(),
    DobleOTriple(),
    RaizOCuadrado(),
    PerimetroCirculo(),
    DiaLaboral(),
    CalculadoraImpuestos(),
    BuscadorResiduo(),
    SumaPares(),
    DiferenciaFracciones(),
    LongitudCadena(),
    PromedioCuatro(),
    MenorDeCinco(),
    ContadorVocales(),
    CalculadoraFactorial(),
    ValidadorRango(),
  ]);

  aplicacion.iniciar();
}

/// Clase abstracta que permite aplicar herencia y polimorfismo.
abstract class Ejercicio {
  int get numero;
  String get nombre;
  String get descripcion;
  void ejecutar();
}

class AplicacionEjercicios {
  final List<Ejercicio> _ejercicios;

  AplicacionEjercicios(this._ejercicios);

  void iniciar() {
    int opcion;
    do {
      _mostrarMenu();
      opcion = Entrada.leerEntero('Seleccione una opción: ');

      if (opcion == 0) {
        print('\nPrograma finalizado. ¡Hasta pronto!');
      } else {
        final coincidencias =
            _ejercicios.where((ejercicio) => ejercicio.numero == opcion);
        if (coincidencias.isEmpty) {
          print('\nOpción no válida. Elija un número entre 0 y 15.');
        } else {
          final ejercicio = coincidencias.first;
          print('\n=== ${ejercicio.nombre} ===');
          print(ejercicio.descripcion);
          ejercicio.ejecutar();
          Entrada.pausar();
        }
      }
    } while (opcion != 0);
  }

  void _mostrarMenu() {
    print('\n==============================================');
    print(' FUNDAMENTOS DE PROGRAMACIÓN EN DART');
    print('==============================================');
    for (final ejercicio in _ejercicios) {
      print('${ejercicio.numero.toString().padLeft(2)}. ${ejercicio.nombre}');
    }
    print(' 0. Salir');
    print('==============================================');
  }
}

class Entrada {
  static String leerTexto(String mensaje) {
    while (true) {
      stdout.write(mensaje);
      final valor = stdin.readLineSync()?.trim() ?? '';
      if (valor.isNotEmpty) return valor;
      print('La entrada no puede estar vacía.');
    }
  }

  static int leerEntero(String mensaje) {
    while (true) {
      final valor = leerTexto(mensaje);
      final numero = int.tryParse(valor);
      if (numero != null) return numero;
      print('Entrada inválida. Escriba un número entero.');
    }
  }

  static double leerDecimal(String mensaje) {
    while (true) {
      final valor = leerTexto(mensaje).replaceAll(',', '.');
      final numero = double.tryParse(valor);
      if (numero != null) return numero;
      print('Entrada inválida. Escriba un número válido.');
    }
  }

  static double leerDecimalNoCero(String mensaje) {
    while (true) {
      final numero = leerDecimal(mensaje);
      if (numero != 0) return numero;
      print('El valor no puede ser cero.');
    }
  }

  static void pausar() {
    stdout.write('\nPresione Enter para volver al menú...');
    stdin.readLineSync();
  }
}

String formatearNumero(num valor) {
  if (valor.isFinite && valor == valor.roundToDouble()) {
    return valor.toInt().toString();
  }
  return valor.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0+$'), '');
}

// 1. Potencia positiva
class PotenciaPositiva implements Ejercicio {
  @override
  int get numero => 1;
  @override
  String get nombre => 'Potencia positiva';
  @override
  String get descripcion =>
      'Eleva un número al cuadrado si es positivo; informa si es negativo.';

  @override
  void ejecutar() {
    final n = Entrada.leerDecimal('Ingrese un número: ');
    if (n > 0) {
      print('Resultado: ${formatearNumero(n * n)}');
    } else if (n < 0) {
      print('Resultado: Número negativo.');
    } else {
      print('Resultado: 0');
    }
  }
}

// 2. Doble o triple
class DobleOTriple implements Ejercicio {
  @override
  int get numero => 2;
  @override
  String get nombre => 'Doble o triple';
  @override
  String get descripcion =>
      'Devuelve el doble del primero si es mayor; de lo contrario, el triple del segundo.';

  @override
  void ejecutar() {
    final primero = Entrada.leerDecimal('Primer número: ');
    final segundo = Entrada.leerDecimal('Segundo número: ');
    final resultado = primero > segundo ? primero * 2 : segundo * 3;
    print('Resultado: ${formatearNumero(resultado)}');
  }
}

// 3. Raíz o cuadrado
class RaizOCuadrado implements Ejercicio {
  @override
  int get numero => 3;
  @override
  String get nombre => 'Raíz o cuadrado';
  @override
  String get descripcion =>
      'Calcula la raíz si el número es positivo; si no, calcula su cuadrado.';

  @override
  void ejecutar() {
    final n = Entrada.leerDecimal('Ingrese un número: ');
    final resultado = n > 0 ? sqrt(n) : n * n;
    print('Resultado: ${formatearNumero(resultado)}');
  }
}

// 4. Perímetro de un círculo
class PerimetroCirculo implements Ejercicio {
  @override
  int get numero => 4;
  @override
  String get nombre => 'Perímetro de un círculo';
  @override
  String get descripcion => 'Calcula el perímetro mediante 2 × π × radio.';

  @override
  void ejecutar() {
    double radio;
    do {
      radio = Entrada.leerDecimal('Radio del círculo: ');
      if (radio < 0) print('El radio no puede ser negativo.');
    } while (radio < 0);
    final perimetro = 2 * pi * radio;
    print('Resultado: ${perimetro.toStringAsFixed(2)}');
  }
}

// 5. Día laboral
class DiaLaboral implements Ejercicio {
  @override
  int get numero => 5;
  @override
  String get nombre => 'Día laboral';
  @override
  String get descripcion =>
      'Muestra el día correspondiente, considerando como laborales del 1 al 5.';

  @override
  void ejecutar() {
    final dia = Entrada.leerEntero('Ingrese un número del 1 al 7: ');
    switch (dia) {
      case 1:
        print('Resultado: Lunes');
        break;
      case 2:
        print('Resultado: Martes');
        break;
      case 3:
        print('Resultado: Miércoles');
        break;
      case 4:
        print('Resultado: Jueves');
        break;
      case 5:
        print('Resultado: Viernes');
        break;
      default:
        print('Resultado: Número fuera del rango laboral.');
    }
  }
}

// 6. Calculadora de impuestos
class CalculadoraImpuestos implements Ejercicio {
  @override
  int get numero => 6;
  @override
  String get nombre => 'Calculadora de impuestos';
  @override
  String get descripcion =>
      'Calcula el 15 % de la parte del salario anual que exceda 12 000.';

  @override
  void ejecutar() {
    double salario;
    do {
      salario = Entrada.leerDecimal('Salario anual: ');
      if (salario < 0) print('El salario no puede ser negativo.');
    } while (salario < 0);

    if (salario > 12000) {
      final impuesto = (salario - 12000) * 0.15;
      print('Impuesto a pagar: ${formatearNumero(impuesto)}');
    } else {
      print('Resultado: No debe impuestos.');
    }
  }
}

// 7. Residuo
class BuscadorResiduo implements Ejercicio {
  @override
  int get numero => 7;
  @override
  String get nombre => 'Residuo de una división';
  @override
  String get descripcion => 'Calcula el residuo del primer entero entre el segundo.';

  @override
  void ejecutar() {
    final dividendo = Entrada.leerEntero('Dividendo: ');
    int divisor;
    do {
      divisor = Entrada.leerEntero('Divisor: ');
      if (divisor == 0) print('El divisor no puede ser cero.');
    } while (divisor == 0);
    print('Resultado: ${dividendo % divisor}');
  }
}

// 8. Suma de pares
class SumaPares implements Ejercicio {
  @override
  int get numero => 8;
  @override
  String get nombre => 'Suma de números pares';
  @override
  String get descripcion => 'Suma los números pares comprendidos entre 1 y 50.';

  @override
  void ejecutar() {
    var suma = 0;
    for (var i = 2; i <= 50; i += 2) {
      suma += i;
    }
    print('Resultado: $suma');
  }
}

// 9. Diferencia de fracciones
class Fraccion {
  final int numerador;
  final int denominador;

  Fraccion(int numerador, int denominador)
      : numerador = denominador < 0 ? -numerador : numerador,
        denominador = denominador < 0 ? -denominador : denominador {
    if (denominador == 0) {
      throw ArgumentError('El denominador no puede ser cero.');
    }
  }

  Fraccion restar(Fraccion otra) {
    final nuevoNumerador =
        numerador * otra.denominador - otra.numerador * denominador;
    final nuevoDenominador = denominador * otra.denominador;
    return Fraccion(nuevoNumerador, nuevoDenominador).simplificar();
  }

  Fraccion simplificar() {
    final divisor = _mcd(numerador.abs(), denominador.abs());
    return Fraccion(numerador ~/ divisor, denominador ~/ divisor);
  }

  int _mcd(int a, int b) {
    while (b != 0) {
      final resto = a % b;
      a = b;
      b = resto;
    }
    return a == 0 ? 1 : a;
  }

  @override
  String toString() => denominador == 1 ? '$numerador' : '$numerador/$denominador';
}

class DiferenciaFracciones implements Ejercicio {
  @override
  int get numero => 9;
  @override
  String get nombre => 'Diferencia de fracciones';
  @override
  String get descripcion => 'Resta dos fracciones y simplifica el resultado.';

  @override
  void ejecutar() {
    print('Primera fracción:');
    final primera = _leerFraccion();
    print('Segunda fracción:');
    final segunda = _leerFraccion();
    print('Resultado: ${primera.restar(segunda)}');
  }

  Fraccion _leerFraccion() {
    final numerador = Entrada.leerEntero('  Numerador: ');
    int denominador;
    do {
      denominador = Entrada.leerEntero('  Denominador: ');
      if (denominador == 0) print('  El denominador no puede ser cero.');
    } while (denominador == 0);
    return Fraccion(numerador, denominador);
  }
}

// 10. Longitud de cadena
class LongitudCadena implements Ejercicio {
  @override
  int get numero => 10;
  @override
  String get nombre => 'Longitud de una palabra';
  @override
  String get descripcion => 'Muestra la cantidad de caracteres del texto ingresado.';

  @override
  void ejecutar() {
    final texto = Entrada.leerTexto('Ingrese una palabra o texto: ');
    print('Resultado: ${texto.runes.length}');
  }
}

// 11. Promedio de cuatro
class PromedioCuatro implements Ejercicio {
  @override
  int get numero => 11;
  @override
  String get nombre => 'Promedio de cuatro números';
  @override
  String get descripcion => 'Calcula la media aritmética de cuatro números.';

  @override
  void ejecutar() {
    final numeros = <double>[];
    for (var i = 1; i <= 4; i++) {
      numeros.add(Entrada.leerDecimal('Número $i: '));
    }
    final promedio = numeros.reduce((a, b) => a + b) / numeros.length;
    print('Resultado: ${formatearNumero(promedio)}');
  }
}

// 12. Menor de cinco
class MenorDeCinco implements Ejercicio {
  @override
  int get numero => 12;
  @override
  String get nombre => 'Menor de cinco números';
  @override
  String get descripcion => 'Busca el menor valor dentro de cinco números.';

  @override
  void ejecutar() {
    final numeros = <double>[];
    for (var i = 1; i <= 5; i++) {
      numeros.add(Entrada.leerDecimal('Número $i: '));
    }
    final menor = numeros.reduce(min);
    print('Resultado: ${formatearNumero(menor)}');
  }
}

// 13. Contador de vocales
class ContadorVocales implements Ejercicio {
  @override
  int get numero => 13;
  @override
  String get nombre => 'Contador de vocales';
  @override
  String get descripcion => 'Cuenta las vocales, incluidas las vocales con tilde.';

  @override
  void ejecutar() {
    final texto = Entrada.leerTexto('Ingrese una palabra o frase: ').toLowerCase();
    const vocales = 'aeiouáéíóúü';
    var cantidad = 0;
    for (final codigo in texto.runes) {
      if (vocales.contains(String.fromCharCode(codigo))) cantidad++;
    }
    print('Resultado: $cantidad vocal(es).');
  }
}

// 14. Factorial
class CalculadoraFactorial implements Ejercicio {
  @override
  int get numero => 14;
  @override
  String get nombre => 'Factorial';
  @override
  String get descripcion => 'Calcula el factorial de un entero no negativo.';

  @override
  void ejecutar() {
    int n;
    do {
      n = Entrada.leerEntero('Ingrese un entero no negativo: ');
      if (n < 0) print('El factorial no está definido para enteros negativos.');
    } while (n < 0);

    BigInt factorial = BigInt.one;
    for (var i = 2; i <= n; i++) {
      factorial *= BigInt.from(i);
    }
    print('Resultado: $factorial');
  }
}

// 15. Validación de rango
class ValidadorRango implements Ejercicio {
  @override
  int get numero => 15;
  @override
  String get nombre => 'Validador de rango';
  @override
  String get descripcion => 'Comprueba si un número está entre 10 y 20, inclusive.';

  @override
  void ejecutar() {
    final n = Entrada.leerDecimal('Ingrese un número: ');
    if (n >= 10 && n <= 20) {
      print('Resultado: Está en el rango.');
    } else {
      print('Resultado: Fuera del rango.');
    }
  }
}
