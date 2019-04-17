---
# vim: set spell spelllang=pt_br sw=4:
title: Cálculo Lambda
---

#.  Avalie (reduza) as expressões a seguir.

    #.  $(\lambda x.x\lambda y.xxy)(\lambda z.zt)r$

        $\underline{(\lambda x.x\lambda y.xxy)(\lambda z.zt)}r$

        $\beta \to (\lambda z.zt)(\lambda y.(\lambda z.zt)\underline{(\lambda z.zt)}y)r$

        $\alpha \to (\lambda z.zt)(\lambda y.\underline{(\lambda z.zt)(\lambda a.at)}y)r$

        $\beta \to (\lambda z.zt)(\lambda y.(\underline{(\lambda a.at)t})y)r$

        $\beta \to \underline{(\lambda z.zt)(\lambda y.tty)}r$

        $\beta \to (\underline{(\lambda y.tty)t})r$

        $\beta \to tttr$

    #.  $(\lambda abc.cba)zz(\lambda wv.w)$

    #.  $(\lambda xyz.xz(yz))(\lambda x.z)(\lambda x.a)$

    #.  $(\lambda z.z)(\lambda z.zz)(\lambda z.zy)$

#.  Nem todas as expressões lambda podem ser avaliadas para uma forma normal. Verifique o que acontece quando tentamos reduzir a expressão $(\lambda x.xx)(\lambda y.yy)$

    Reduzindo $(\lambda x.xx)(\lambda y.yy)$, temos:

    $(xx)[x:=\lambda y.yy] = (\lambda y.yy)(\lambda y.yy) \equiv (\lambda x.xx)(\lambda y.yy)$

    o que representa a expressão inicial que tentamos reduzir. Dessa forma, reduções consecutivas sempre levarão à mesma expressão inicial, repetidas vezes, nunca atingindo uma forma irredutível.

#.  Uma expressão lambda que não possui variáveis livres é chamada de fechada, ou **combinador**. Determine se as expressões a seguir são fechadas. Caso não seja, justifique.

    #.  $\lambda x.xx$

        Fechada.

    #.  $\lambda xy.yx$

        Fechada.

    #.  $\lambda xy.zx$

        Não-fechada, pois $z$ é livre na abstração.

    #.  $(\lambda v.vw)v$

        Não-fechada, pois $w$ é livre na abstração.

    #.  $\lambda xyz.y(xz)$

        Fechada.

    #.  $\lambda xz.xy(xzy)$

        Não-fechada, pois $y$ é livre na abstração.

#.  Verifique as equivalências a seguir considerando as construções aritméticas vistas em aula.

    #.  $S(S2) \equiv 4$

        $S(\underline{S2})$

        $\alpha \to S(\underline{(\lambda wyx.y(wyx))(\lambda sz.s(sz))})$

        $\beta \to S(\lambda yx.y(\underline{(\lambda sz.s(sz))yx}))$

        $\beta \to S(\underline{\lambda yx.y(y(yx))})$

        $\alpha \to \underline{S}(\lambda sz.s(s(sz))) \equiv S3$

        $\alpha \to \underline{(\lambda wyx.y(wyx))(\lambda sz.s(s(sz)))}$

        $\beta \to \lambda yx.y(\underline{(\lambda sz.s(s(sz)))yx})$

        $\beta \to \underline{\lambda yx.y(y(y(yx)))}$

        $\alpha \to \lambda sz.s(s(s(sz))) \equiv 4$

    #.  $2S3 \equiv 5$

    #.  $M32 \equiv 6$
