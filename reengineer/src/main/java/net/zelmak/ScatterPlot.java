package net.zelmak;


import java.awt.Color;
import java.awt.Graphics;
import java.awt.Point;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;
import javax.swing.JFrame;
import javax.swing.JPanel;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author brad
 */
public class ScatterPlot {
    public static void main(String[] args) {
        JFrame f = new JFrame("ScatterPlot");
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        JPanel canvas = new JPanel();
        canvas.setOpaque(true);
        
        
        f.pack();
        f.setVisible(true);
    }
    
    static class Canvas extends JPanel {
        Map<Double, Double> data = new TreeMap<>();
        
        @Override
        public void paintComponent(Graphics g) {
            g.setColor(Color.WHITE);
            g.clearRect(0, 0, this.getWidth(), this.getHeight());
            g.setColor(Color.BLACK);
            boolean first = true;
            Point currentPoint = new Point();
            for (Entry<Double, Double> e : data.entrySet()) {
                if (first) {
                    
                    first = false;
                } else {
                    
                }
            }
        }
        
        
    }
}
