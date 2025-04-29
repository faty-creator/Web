
package services;

import dao.UserDao;
import entities.User;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class UserService implements IService<User> {

    private final UserDao ud;

    public UserService() {
        this.ud = new UserDao();
    }

    public UserService(UserDao ud) {
        this.ud = ud;
    }

    @Override
    public boolean create(User o) {
        return ud.create(o);
    }

    @Override
    public boolean delete(User o) {
        return ud.delete(o);
    }

    @Override
    public boolean update(User o) {
        return ud.update(o);
    }

    @Override
    public List<User> findAll() {
        return ud.findAll();
    }

    @Override
    public User findById(int id) {
        return ud.findById(id);
    }

     public List<User> findByEmail(String email) {
        return ud.findByEmail(email);
    }
}
