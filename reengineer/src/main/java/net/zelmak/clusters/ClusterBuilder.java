/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.zelmak.clusters;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/**
 *
 * @author Brad
 */
class ClusterBuilder {

    Map<Double, Integer> buildSlopes(List<Double> data) {
        Map<Double, Integer> slopes = new TreeMap<>();
        slopes.put(10.0, 20);
        return slopes;
    }

}
