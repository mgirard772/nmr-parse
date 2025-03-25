import gradio as gr
import yaml
import nmr_parse

with open('config.yaml', 'r') as file:
    config = yaml.safe_load(file)


def app_parse_nmr(nmr_string: str) -> [str, str]:
    result = nmr_parse.parse_nmr(nmr_string)
    return [result, result.replace('J', '_J_')]


with gr.Blocks(
    title='NMR Parser'
) as APP:
    gr.Markdown(config['APP_DESCRIPTION'])
    with gr.Row():
        with gr.Column():
            nmr_input = gr.Textbox(
                label="Input",
                info="NMR value string, comma-separate (with space), in descending order"
            )
            nmr_output = gr.Textbox(
                label="Output",
                info="NMR value string with journal precision",
                show_copy_button=True
            )
            nmr_output_markdown_label = gr.Markdown(
                value="## Formatted Response"
            )
            nmr_output_markdown = gr.Markdown(
                value="Formatted output will appear here",
                label="Formatted Output",
                show_copy_button=True
            )
            with gr.Row():
                nmr_submit = gr.Button(
                    value='Submit',
                    variant='primary'
                )
                nmr_clear = gr.ClearButton(
                    components=[nmr_input, nmr_output, nmr_output_markdown]
                )
    gr.Examples(config['EXAMPLES'], inputs=[nmr_input])
    nmr_submit.click(
        fn=app_parse_nmr,
        inputs=[nmr_input],
        outputs=[nmr_output, nmr_output_markdown],
        api_name='nmr_parse'
    )
    nmr_input.submit(
        fn=app_parse_nmr,
        inputs=[nmr_input],
        outputs=[nmr_output, nmr_output_markdown],
        show_api=False
    )

if __name__ == '__main__':
    APP.launch(
        server_port=12345,
        server_name='0.0.0.0'
    )
