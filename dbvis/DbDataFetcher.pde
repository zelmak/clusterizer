static final String slopeQuery 
  = "select * from parm_slope " 
  //+ "  where parm_value < 102 " 
  + "  order by parm_value";

static final String inputQuery
  = "select trunc(parm_value, 1), count(1) " 
  + " from parm_input " 
  //+ "  where parm_value < 102 " 
  + "  group by trunc(parm_value,1) " 
  + "  having count(1) > 1 " 
  + "  order by trunc(parm_value,1)";

static final String rangeQuery 
  = "select * " 
  + "  from cluster_out " 
  + "  order by min_value, max_value";

static final String thresholdQuery 
  = "select substr(msg, length('thresh: ')) " 
  + "  from debug_log "
  + "  where msg like 'thresh: %'";
  
class DbDataFetcher {
  void fillInData() {
    Connection conn;
    try {
      conn = DriverManager.getConnection("jdbc:oracle:thin:@oracle12c.lan:1521:homedb", "brad", "abc123");
      Statement st;
      try {
        st = conn.createStatement();
        ResultSet rs;
        try {
          rs = st.executeQuery(slopeQuery);
          while (rs.next()) {
            Point p = new Point(rs.getFloat(1), rs.getFloat(2));
            slopeData.add(p);
          }
          rs = st.executeQuery(inputQuery);
          while (rs.next()) {
            Point p = new Point(rs.getFloat(1), rs.getFloat(2));
            inputData.add(p);
          }
          rs = st.executeQuery(rangeQuery);
          while (rs.next()) {
            Range r = new Range(rs.getFloat(1), rs.getFloat(2));
            ranges.add(r);
          }
          rs = st.executeQuery(thresholdQuery);
          if (rs.next()) {
            threshold = rs.getFloat(1);
            print("Threshold: " + threshold);
          }
        } 
        catch (SQLException e) {
          System.err.println("trouble with result-set: " + e);
        }
      } 
      catch (SQLException e) {
        System.err.println("trouble with statement: " + e);
      }
    } 
    catch (SQLException e) {
      System.err.println("trouble with connection: " + e);
    }
  }
}
