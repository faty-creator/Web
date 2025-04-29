package entities;

import javax.persistence.Entity;
import javax.persistence.Table;
import org.hibernate.annotations.NamedQuery;

@Entity
@NamedQuery(name = "findAdminByEmail", query = "FROM Admin a WHERE a.email = :email")
@Table(name = "admins")
public class Admin extends User {

    public Admin() {
    }

    public Admin(String nom, String prenom, String email, String motDePasse) {
        super(nom, prenom, email, motDePasse);
    }
}
