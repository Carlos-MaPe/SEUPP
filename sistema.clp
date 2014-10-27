;;;;
;Sistema experto: Curación de UPP(úlceras por presion)

	;;========PLANTILLAS========;;
	(deftemplate ulcera
		(slot piel-integra		;S → GRADOI
			(type SYMBOL) 
			(allowed-symbols S s N n -)
			(default -)
		)
		(slot perdida-parcial 	;S → GRADOII
			(type SYMBOL)
			(allowed-symbols S s N n -)
			(default -)
		)
		(slot perdida-tejido	;S → GRADOIV, N → GRADOIII
			(type SYMBOL)
			(allowed-symbols S s N n -)
			(default -)
		)
		(slot infeccion
			(type SYMBOL)
			(allowed-symbols S s N n -)
			(default -)
		)
		(slot mal-olor
			(type SYMBOL)
			(allowed-symbols S s N n -)
			(default -)
		)
		(slot epitelizacion
			(type SYMBOL)
			(allowed-symbols S s N n -)
			(default -)
		)
		(slot granulacion
			(type SYMBOL)
			(allowed-symbols S s N n -)
			(default -)
		)
		(slot exudoracion
			(type SYMBOL)
			(allowed-symbols S s N n -)
			(default -)
		)
		(slot hipergranulacion
			(type SYMBOL)
			(allowed-symbols S s N n -)
			(default -)
		)
		(slot necrosis
			(type SYMBOL)
			(allowed-symbols S s N n -)
			(default -)
		)
		(slot esfacelos
			(type SYMBOL)
			(allowed-symbols S s N n -)
			(default -)
		)
	)
	;;==========HECHOS==========;;
	;(deffacts hechos-inicio
	;	(ulcera
	;		(piel-integra S)
	;	)
		;(HECHO1)
	;)
	;;==========REGLAS==========;;
	;;==GRADOI==;;
	(defrule gradoi "Descripción para UPP de Grado I"
		(ulcera (piel-integra s|S))
		=>
		(printout t "La úlcera a tratar es una de GRADO I. Se caracteriza por presentar enrojecimiento de la zona que no palidece ni cede al ejercer presión sobre ella." crlf)
	)
	
	;;==GRADOII==;;
	(defrule gradoii-granulacion "Descripcion para una UPP de Grado II con granulacion"
		(ulcera (piel-integra n|N) (perdida-parcial s|S) (granulacion s|S) (exudoracion s|S|n|N))
		=>
		(printout t "La úlcera a tratar es una de GRADO II con granulacion. Se caracteriza por presentar una pérdida parcial del grosor de la piel que puede afectar a epidermis, dermis o ambas. Suele tener aspecto de abrasión, ampolla o cráter superficial. Puede presentar exudoración" crlf)
	)
	(defrule gradoii-epitelizacion "Tratamiento para una UPP de Grado II con epitelizacion"
		(ulcera (piel-integra n|N) (perdida-parcial s|S) (epitelizacion s|S))
		=>
		(printout t "La úlcera a tratar es una de GRADO II con epitelizacion. Se caracteriza por presentar una pérdida parcial del grosor de la piel que puede afectar a epidermis, dermis o ambas. Suele tener aspecto de abrasión, ampolla o cráter superficial. No presenta exudoración" crlf)
	)
	;;==GRADOIII==;;
	(defrule gradoiii "Descripcion para una UPP de Grado III"
		(ulcera (piel-integra n|N) (perdida-parcial n|N) (perdida-tejido n|N))
		=>
		(printout t "La úlcera a tratar es una de GRADO III. Se caracteriza por presentar una pérdida total del grosor de la piel, con lesión de tejido subcutáneo que puede llegar hasta fascia muscular. Puede aparecer necrosis y lesiones tunelizadas." crlf)
	) 		
	;;==GRADOIV==;;
	(defrule gradoiv "Descripcion para una UPP de Grado IV"
		(ulcera (piel-integra n|N) (perdida-parcial n|N) (perdida-tejido s|S))
		=>
		(printout t "La úlcera a tratar es una de GRADO IV. Se caracteriza por una pérdida total del grosor de la piel con destrucción extensa, lesión en músculo, hueso y/o estructuras de sostén (tendón, cápsula articular, etc.). Existe necrosis, lesiones tunelizadas y en cavernas." crlf)
	)
	
	;=Tratamiento GI
	(defrule gradoi-tto "Tratamiento para UPP de Grado I"
		(ulcera (piel-integra s|S))
		=>
		(printout t "El tratamiento persigue restablecer la barrera hidrolipídica y para ello se debe aplicar en la zona: " 
			crlf "- Ácidos grasos hiperoxigenados"
			crlf "- Cremas barreras con óxido de Zinc"
			crlf "- También se aconseja su protección usando acolchamientos para reducir la presión en la zona" crlf
		)
	)
	
	;=Tratamiento GII/III/IV con granulación y exudoracion
	(defrule upp-granulacion-ex "Tratamiento para la UPP con granulacion y exudoracion"
		(ulcera (piel-integra n|N) (perdida-parcial s|S|n|N) (granulacion s|S) (exudoracion s|S))
		=>
		(printout t "El tratamiento a aplicar en la ulcera con exudoracion: " 
			crlf "- Alginato (Plata)"
			crlf "- Apósito secundario (Hidrocoloide o espuma)" crlf
		)
	)

	;=Tratamiento GII/III/IV con granulación y no exudoracion
	(defrule upp-granulacion-noex "Tratamiento para la UPP con granulacion"
		(ulcera (piel-integra n|N) (perdida-parcial s|S|n|N) (granulacion s|S) (exudoracion n|N))
		=>
		(printout t "El tratamiento a aplicar en la ulcera sin exudoracion: " 
			crlf "- Hidrogel"
			crlf "- Apósito secundario (Hidrocoloide o espuma)" crlf)
	)

	;=Tratamiento GII/III/IV con epitelizacion
	(defrule upp-epitelizacion "Tratamiento para la UPP con epitelizacion"
		(ulcera (piel-integra n|N) (perdida-parcial s|S|n|N) (epitelizacion s|S))
		=>
		(printout t "Para favorecer la epitelización se aplicará en la zona afectada:"
		crlf "- Colágeno"
		crlf "- Apósitos secundarios (Hidrocoloides o espumas)" crlf)
	) 
	;=Tratamiento

	;;====MOTOR DE INFERENCIA===;;