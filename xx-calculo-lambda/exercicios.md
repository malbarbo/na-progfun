---
# vim: set spell spelllang=pt_br sw=4:
title: Cálculo Lambda
---

#.  Avalie (reduza) as expressões a seguir.

    #.  $(\lambda x.x\lambda y.xxy)(\lambda z.zt)r$

    #.  $(\lambda abc.cba)zz(\lambda wv.w)$

    #.  $(\lambda xyz.xz(yz))(\lambda x.z)(\lambda x.a)$

    #.  $(\lambda z.z)(\lambda z.zz)(\lambda z.zy)$

#.  Nem todas as expressões lambda podem ser avaliadas para uma forma normal.
    Verifique o que acontece quando tentamos reduzir a expressão $(\lambda
    x.xx)(\lambda y.yy)$

#.  Uma expressão lambda que não possui variáveis livres é chamada de fechada,
    ou **combinador**. Determine se as expressões a seguir são fechadas. Caso
    não seja, justifique.

    #.  $\lambda x.xx$

    #.  $\lambda xy.yx$

    #.  $\lambda xy.zx$

    #.  $(\lambda v.vw)v$

    #.  $\lambda xyz.y(xz)$

    #.  $\lambda xz.xy(xzy)$

#.  Verifique as equivalências a seguir considereando as construções
    aritméticas vistas em aula.

    #.  $S(S2) \equiv 4$

    #.  $2S3 \equiv 5$

    #.  $M32 \equiv 6$
