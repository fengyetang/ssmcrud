import com.tangfengye.crud.bean.Department;
import com.tangfengye.crud.bean.Employee;
import com.tangfengye.crud.dao.DepartmentMapper;
import com.tangfengye.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/*
* 推荐Spring的项目就可以使用Spring的单元测试，可以自动注入需要的组建
* 1.导入SpringTest
* 2.ContextConfiguration指定Spring配置文件的位置
* 3.直接autuwired即可
* */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){
     /*   //1.创建SpringIOC容器
        ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext");
        //2.从容器中获取mapper
        ioc.getBean(DepartmentMapper.class);
        //3*/
    // System.out.println(departmentMapper);
    // departmentMapper.insertSelective(new Department(null,"开发部"));
    // departmentMapper.insertSelective(new Department(null,"测试部"));
     //2.生成员工数据，测试员工插入
  // employeeMapper.insertSelective(new Employee(null,"lucy","M","lucy@tangfengye.com",1));
     //
        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0;i<1000;i++){
            String uid=UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@tangfengye.com",1));
        }
        System.out.println("批量完成");
       }
}
