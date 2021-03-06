// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ar.um.edu.programacion2.trabajofinal.domain;

import ar.um.edu.programacion2.trabajofinal.domain.Juego;
import ar.um.edu.programacion2.trabajofinal.domain.JuegoDataOnDemand;
import ar.um.edu.programacion2.trabajofinal.domain.JuegoIntegrationTest;
import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect JuegoIntegrationTest_Roo_IntegrationTest {
    
    declare @type: JuegoIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: JuegoIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: JuegoIntegrationTest: @Transactional;
    
    @Autowired
    JuegoDataOnDemand JuegoIntegrationTest.dod;
    
    @Test
    public void JuegoIntegrationTest.testCountJuegoes() {
        Assert.assertNotNull("Data on demand for 'Juego' failed to initialize correctly", dod.getRandomJuego());
        long count = Juego.countJuegoes();
        Assert.assertTrue("Counter for 'Juego' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void JuegoIntegrationTest.testFindJuego() {
        Juego obj = dod.getRandomJuego();
        Assert.assertNotNull("Data on demand for 'Juego' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Juego' failed to provide an identifier", id);
        obj = Juego.findJuego(id);
        Assert.assertNotNull("Find method for 'Juego' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'Juego' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void JuegoIntegrationTest.testFindAllJuegoes() {
        Assert.assertNotNull("Data on demand for 'Juego' failed to initialize correctly", dod.getRandomJuego());
        long count = Juego.countJuegoes();
        Assert.assertTrue("Too expensive to perform a find all test for 'Juego', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<Juego> result = Juego.findAllJuegoes();
        Assert.assertNotNull("Find all method for 'Juego' illegally returned null", result);
        Assert.assertTrue("Find all method for 'Juego' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void JuegoIntegrationTest.testFindJuegoEntries() {
        Assert.assertNotNull("Data on demand for 'Juego' failed to initialize correctly", dod.getRandomJuego());
        long count = Juego.countJuegoes();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Juego> result = Juego.findJuegoEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'Juego' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Juego' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void JuegoIntegrationTest.testFlush() {
        Juego obj = dod.getRandomJuego();
        Assert.assertNotNull("Data on demand for 'Juego' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Juego' failed to provide an identifier", id);
        obj = Juego.findJuego(id);
        Assert.assertNotNull("Find method for 'Juego' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyJuego(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'Juego' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void JuegoIntegrationTest.testMergeUpdate() {
        Juego obj = dod.getRandomJuego();
        Assert.assertNotNull("Data on demand for 'Juego' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Juego' failed to provide an identifier", id);
        obj = Juego.findJuego(id);
        boolean modified =  dod.modifyJuego(obj);
        Integer currentVersion = obj.getVersion();
        Juego merged = obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'Juego' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void JuegoIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'Juego' failed to initialize correctly", dod.getRandomJuego());
        Juego obj = dod.getNewTransientJuego(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'Juego' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'Juego' identifier to be null", obj.getId());
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
        Assert.assertNotNull("Expected 'Juego' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void JuegoIntegrationTest.testRemove() {
        Juego obj = dod.getRandomJuego();
        Assert.assertNotNull("Data on demand for 'Juego' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Juego' failed to provide an identifier", id);
        obj = Juego.findJuego(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'Juego' with identifier '" + id + "'", Juego.findJuego(id));
    }
    
}
