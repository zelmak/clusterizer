/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.zelmak.clusters;

import java.util.Map;
import org.junit.After;
import org.junit.AfterClass;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 *
 * @author Brad
 */
public class ClusterBuilderTest {
    
    public ClusterBuilderTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    // TODO add test methods here.
    // The methods must be annotated with annotation @Test. For example:
    //
    @Test
    public void canBuildSlopesProperly() {
        ClusterBuilder cb = new ClusterBuilder();
        assertNotNull(cb);
        Map<Double, Integer> slopes = cb.buildSlopes(InputData.DATA);
        assertFalse(slopes.isEmpty());
    }
}
