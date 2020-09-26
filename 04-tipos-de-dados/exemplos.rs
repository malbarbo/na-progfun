#![allow(dead_code)]

// Tipos algebricos

// Tipo produto
#[derive(Debug)]
struct Par<T1, T2> {
    a: T1,
    b: T2,
}

#[derive(Debug)]
struct Nada {}

#[derive(Debug)]
enum Cor {
    Vermelho,
    Amarelo,
    Verde,
}

#[derive(Debug)]
// Tipo soma
enum UmOuOutro<T1, T2> {
    Um(T1),
    Outro(T2),
}

#[derive(Debug)]
enum Vazio {}

fn avanca(idade: &Option<u32>) -> Option<u32> {
    idade.map(|x| *x + 1)
}

struct Mensagem {
    msg: Option<String>,
    sucesso: Option<u32>,
    erro: Option<u32>,
}

/*
     msg             sucesso       erro
(None + String) * (None + u32) * (None + u32)
(None * None + None * u32 + String * None + String * u32) * (None + u32)

None * None * None +   // ok: sem mesagem
None * None * u32 +    // !
None * u32 * None +    // !
None * u32 * u32 +     // !
String * None * None + // !
String * None * u32 +  // ok: caso do erro
String * u32 * None +  // ok: caso de sucesso
String * u32 * u32     // !
*/

// Nunca permita valores inválidos!
enum Mensagem {
    Nenhum,
    Erro(String, u32),
    Sucesso(String, u32),
}

pub fn main() {
    let idade = None;
    assert_eq!(avanca(&idade), None);
    let idade = Some(3);
    assert_eq!(avanca(&idade), Some(4));
    let x = Par { a: Nada {}, b: true };
    let n = Nada {};
    let a = UmOuOutro::<Vazio, bool>::Outro(false);

    println!("{:?}", x);
    println!("{:?}", n);
    println!("{:?}", a);
}
