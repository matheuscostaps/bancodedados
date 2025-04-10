package apresentacao;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JComboBox;
import javax.swing.JRadioButton;
import javax.swing.JTextField;

public class ControladorLimpar implements ActionListener {

	// Propiedades da Classe 
	private JTextField txtNome = null;
	private JRadioButton optMasculino = null;
	private JTextField txtEndereco = null;
	private JComboBox<String> cboUF = null;
	
	// Metodos Construtores cheio da Classe (Nao ha construtor vazio em caixa de controle)
	public ControladorLimpar(JTextField txtNome, JRadioButton optMasculino, JTextField txtEndereco,
			JComboBox<String> cboUF) {
		super();
		this.txtNome = txtNome;
		this.optMasculino = optMasculino;
		this.txtEndereco = txtEndereco;
		this.cboUF = cboUF;
		
	}
	
	// Metodo implementado da Interface
	public void actionPerformed(ActionEvent e) {
	txtNome.setText("");
	optMasculino.setSelected(true);
	txtEndereco.setText("");
	cboUF.setSelectedIndex(0);

}
	
}
