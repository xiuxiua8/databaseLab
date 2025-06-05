import java.sql.*;
import java.io.*;
import java.util.*;

public class InsertData {
    public static void main(String[] args) throws Exception {
        String url = "jdbc:postgresql://172.25.57.235:8888/postgres";
        String user = "gaussdb";
        String password = "Enmo@123";
        Connection conn = DriverManager.getConnection(url, user, password);

        insertFromCSV(conn, "../resources/students.csv", "S126", 6);
        insertFromCSV(conn, "../resources/courses.csv", "C126", 5);
        insertFromCSV(conn, "../resources/sc.csv", "SC126", 3);

        conn.close();
    }

    public static void insertFromCSV(Connection conn, String file, String table, int cols) throws Exception {
        BufferedReader reader = new BufferedReader(new FileReader(file));
        String line = reader.readLine(); // skip header
        // 生成 (?, ?, ?, ...) 占位符
        StringBuilder sb = new StringBuilder();
        sb.append("?");
        for (int i = 1; i < cols; i++) {
            sb.append(",?");
        }
        String placeholders = sb.toString();
        String conflictClause = "";
        if (table.equals("S126")) conflictClause = " ON CONFLICT (sno) DO NOTHING";
        else if (table.equals("C126")) conflictClause = " ON CONFLICT (cno) DO NOTHING";
        else if (table.equals("SC126")) conflictClause = " ON CONFLICT (sno, cno) DO NOTHING";
        PreparedStatement pstmt = conn.prepareStatement(
            "INSERT INTO " + table + " VALUES (" + placeholders + ")"
        );
        while ((line = reader.readLine()) != null) {
            String[] values = line.split(",");
            if (values.length < cols) continue; // 跳过列数不足的行
            for (int i = 0; i < cols; i++) {
                if (values[i].equals("") || values[i].equalsIgnoreCase("null"))
                    pstmt.setNull(i + 1, Types.NUMERIC);
                else
                    pstmt.setString(i + 1, values[i].trim());
            }
            try {
                pstmt.executeUpdate();
            } catch (SQLException e) {
                // 主键冲突等错误，忽略继续
                if (e.getSQLState().equals("23505")) continue; // 23505是主键冲突
                else throw e;
            }
        }
        reader.close();
    }
}
