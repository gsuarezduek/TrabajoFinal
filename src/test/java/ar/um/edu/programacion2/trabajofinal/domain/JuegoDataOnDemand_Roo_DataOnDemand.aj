// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ar.um.edu.programacion2.trabajofinal.domain;

import ar.um.edu.programacion2.trabajofinal.domain.Juego;
import ar.um.edu.programacion2.trabajofinal.domain.JuegoDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect JuegoDataOnDemand_Roo_DataOnDemand {
    
    declare @type: JuegoDataOnDemand: @Component;
    
    private Random JuegoDataOnDemand.rnd = new SecureRandom();
    
    private List<Juego> JuegoDataOnDemand.data;
    
    public Juego JuegoDataOnDemand.getNewTransientJuego(int index) {
        Juego obj = new Juego();
        return obj;
    }
    
    public Juego JuegoDataOnDemand.getSpecificJuego(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Juego obj = data.get(index);
        Long id = obj.getId();
        return Juego.findJuego(id);
    }
    
    public Juego JuegoDataOnDemand.getRandomJuego() {
        init();
        Juego obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Juego.findJuego(id);
    }
    
    public boolean JuegoDataOnDemand.modifyJuego(Juego obj) {
        return false;
    }
    
    public void JuegoDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Juego.findJuegoEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Juego' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Juego>();
        for (int i = 0; i < 10; i++) {
            Juego obj = getNewTransientJuego(i);
            try {
                obj.persist();
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
