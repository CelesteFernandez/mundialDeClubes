class Equipo {
    const plantel
    var puntos = 0

    method ganaA(unEquipo) {
        return self.potencialDelEquipo() > unEquipo.potencialDelEquipo() * 1.2
    }

    method potencialDelEquipo()

    method plantel() {
        return plantel
    }

    method valoracionEquipo() {
        return plantel.jugadoresConMasDeUnMillon().sum({j => j.valoracion()})
    }

    method ganarPartido() {
        puntos += 3
    }

    method empatarPartido() {
        puntos += 1
    }

    method guerraComercial() {
        plantel.eliminarAlMasCotizado()
    }

    method levantamientoDeLeyesMigratorias()
}

class Plantel {
    const jugadores = #{}

    method valoracionPlantel() {
        return jugadores.sum({j => j.valoracion()})
    }

    method jugadoresConMasDeUnMillon() {
        return jugadores.filter({j => j.valoracion() > 1000000})
    }

    method sacarJugadorConMayorCotizacion() {
        jugadores.remove(self.jugadorConMayorCotizacion())
    }

    method jugadorConMayorCotizacion() {
        return jugadores.sortBy({jugador1, jugador2 => jugador1.cotizacion() > jugador2.cotizacion()}).first()
    }

}

class EquipoEuropeo inherits Equipo {
    var championsConseguidas = 0

    override method potencialDelEquipo() {
        return plantel.valoracionPlantel() * championsConseguidas
    }

    method ganarChampions() {
        championsConseguidas += 1 
    }

    override method levantamientoDeLeyesMigratorias() {}
}

class EquipoConmebol inherits Equipo {
    var popularidad
    var hinchada

    override method potencialDelEquipo() {
        return plantel.valoracionPlantel() * self.motivacionEquipo()
    }

    method motivacionEquipo() {
        return hinchada.motivacion()
    }

    method popularidad() {
        return popularidad
    }

    override method levantamientoDeLeyesMigratorias() {
        self.cambiarPopularidadEn()
        self.cambiarHinchada()
    }

    method cambiarPopularidadEn() {
        popularidad += 100
    }

    method cambiarHinchada() {
        hinchada = hinchada.modificarHinchada()
    }
}

class EquipoEstadosUnidos inherits Equipo {
    const habitantesEnMillones

    override method potencialDelEquipo() {
        return plantel.valoracionPlantel() * habitantesEnMillones
    }

    override method levantamientoDeLeyesMigratorias() {}
}

class EquipoRestoDelMundo inherits Equipo {
    override method potencialDelEquipo() {
        return plantel.valoracionPlantel()
    }

    override method levantamientoDeLeyesMigratorias() {}
}

class Hinchada {
    method motivacionHinchada(unEquipo)
    method modificarHinchada()
} 

class HinchadaEntusiasta inherits Hinchada {
    override method motivacionHinchada(unEquipo) {
        return unEquipo.popularidad() ** 2
    }

    override method modificarHinchada() {
        return self
    }
}

class HinchadaPechoFrio inherits Hinchada {
    override method motivacionHinchada(unEquipo) {
        return [1, unEquipo.popularidad() / 10].max()
    }

    override method modificarHinchada() {
        return new HinchadaEntusiasta() //CHEQUEAR
    }
}

class HinchadaMercenaria inherits Hinchada {
    override method motivacionHinchada(unEquipo) {
        return unEquipo.plantel().valoracionPlantel() * 0.01
    }

    override method modificarHinchada() {
        return new HinchadaPechoFrio() //CHEQUEAR
    }
}

class HinchadaTranqui inherits Hinchada {
    override method motivacionHinchada(unEquipo) {
        return 1
    }

    override method modificarHinchada() {
        return self
    }
}

class Jugador {
    const valoracion
    const cotizacion
    const nombre

    method valoracion() {
        return valoracion
    }

    method cotizacion() {
        return cotizacion * nombre.length()
    }
}

class NuevoJugador inherits Jugador {
    const importePorPremiosRecibidos

    override method cotizacion() {
        return super() + importePorPremiosRecibidos
    }
}

class Partido { 
    const unEquipo
    const otroEquipo

    method jugarPartido() {
        return
        if (unEquipo.ganaA(otroEquipo)) {
            unEquipo.ganarPartido()
        } else if (otroEquipo.ganaA(unEquipo)) {
            otroEquipo.ganarPartido()
        } else {
            unEquipo.empatarPartido()
            otroEquipo.empatarPartido()
        }
    }
}

class grupo {
    const equipos = #{}
    const partidos = []

    method agregarEquipo(unEquipo) {
        if (!equipos.contains(unEquipo)) {
            equipos.add(unEquipo)
        }
    }

    method quitarEquipo(unEquipo) {
        if (equipos.contains(unEquipo)) {
            equipos.remove(unEquipo)
        }
    }

    method agregarPartido(unPartido) {
        partidos.add(unPartido)
    }

    method puntosDelEquipo(unEquipo) {
        partidos.forEach({p => p.jugarPartido()})
    }

    method guerraComercial() {
        equipos.forEach({e => e.guerraComercial()})
    }

    method levantamientoDeLeyesMigratorias() {
         equipos.forEach({e => e.levantamientoDeLeyesMigratorias()})
    }
}