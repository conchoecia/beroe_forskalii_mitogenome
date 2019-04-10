import matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import matplotlib.patches as mplpatches
import matplotlib.lines as mlines

plt.style.use('dark_background')

filename = "/Users/darrin/Science/Haddock/biochem/periphyllina_luciferase/20190325_Q/20190325_Q_results.txt"
outpre = "/Users/darrin/Science/Haddock/biochem/periphyllina_luciferase/20190325_Q/20190325_Q_plot"
out_csv="/Users/darrin/Science/Haddock/biochem/periphyllina_luciferase/20190325_Q/20190325_results_collated.csv"
out_fin="/Users/darrin/Science/Haddock/biochem/periphyllina_luciferase/20190325_Q/20190325_results_processed.csv"
this_y_label = "RLU"
this_fig_title = "Paraphyllina on Q FF in 20mM Tris pH 8.0*4C"
frac_rxn_vol = 50
buff_rxn_vol = 50
buff_rxn_mol = .75
neg_time="8x500ms"
assay_time="13x500ms"
plot_type = "normal"

if plot_type == "short":
    plot_rxn = False
    plot_line = False
    plot_legend = False
    figWidth = 20
    figHeight = 2.5

if plot_type == "normal":
    plot_rxn = True
    plot_line = True
    plot_legend = True
    figWidth = 7.5
    figHeight = 6.5

neg_box = True
neg_bar_width = 0.3

bar_width=0.85

df = pd.read_csv(filename, 
                 sep='\t', header=None)
df.columns= ['time', 'val', 'frac']
df2 = df.pivot('time', 'frac')
df2=df2.T
df2.to_csv(out_csv)
# prevents problems with blank rows

df = pd.read_csv(out_fin, 
                 sep=',', header=0)
df['lum'] = pd.to_numeric(df['lum'])

#mols rxn
mol_rxn = frac_rxn_vol * df['NaCl_Conc']
mol_buff = buff_rxn_vol * buff_rxn_mol
tot_mol = mol_rxn + mol_buff
#total_reaction_volume
trv = buff_rxn_vol + frac_rxn_vol
df['rxn_mol'] = tot_mol/trv

# make an empty column
df['fraction_conc'] = 0

#set the figure dimensions
magic_num = 1.5
plt.figure(figsize=(figWidth,figHeight))

#set the panel dimensions
panelWidth = figWidth-magic_num
panelHeight = figHeight-magic_num

#find the margins to center the panel in figure
leftMargin = magic_num/2
bottomMargin = magic_num/2

x_lims = [0,max(df.fraction) + 0.66]
y_lims = [0,(max(df.lum) + 1)*1.1]

#set the left panel for 5' splice sites
panel0=plt.axes([leftMargin/figWidth, #left
                 bottomMargin/figHeight,    #bottom
                 panelWidth/figWidth,   #width
                 panelHeight/figHeight])     #height
panel0.tick_params(axis='both',which='both',\
                   bottom=True, labelbottom=True,\
                   left=True, labelleft=True, \
                   right=False, labelright=False,\
                   top=False, labeltop=False) 
panel0.set_ylabel(this_y_label)                  
panel0.set_title(this_fig_title)
panel0.set_xlim(x_lims)                   
panel0.set_ylim(y_lims)
panel0.set_xlabel("Fraction")
panel1 = panel0.twinx()
panel1.set_ylim([0,1.1])

slope_collecting = False
prev_slope_x = -1
prev_slope_y = -1
prev_index = -1
for index, row in df.iterrows():
    rectangle1=mplpatches.Rectangle((row['fraction']-0.5,0),bar_width,row['lum'],
                                    linewidth=0,\
                                    linestyle='-',\
                                    edgecolor='black',\
                                    facecolor='teal')
    panel0.add_patch(rectangle1)
    if neg_box:
            rectangle2=mplpatches.Rectangle((row['fraction']-(neg_bar_width/2),0),
                                    neg_bar_width,row['neg'],
                                    linewidth=0,\
                                    linestyle='-',\
                                    edgecolor='black',\
                                    facecolor='black')
            panel0.add_patch(rectangle2)
    if index < (len(df)) and plot_line:
        #finish up plotting a slope if necessary
        if slope_collecting and not pd.isnull(df.loc[index, 'NaCl_Conc']):
            if df.loc[index, 'fraction'] == -1:
                final_x = df.loc[index-1, 'fraction'] + 1
            else:
                final_x = df.loc[index, 'fraction']
            final_y = df.loc[index, 'NaCl_Conc']
            panel1.plot( [prev_slope_x-0.5, final_x-0.5], 
                         [prev_slope_y, final_y], 
                         color='r', linestyle='-', linewidth=2)
            slope_collecting = False
            #now calculate the molarity of the reaction here.
            prev_fraction = df.loc[prev_index, 'fraction']
            this_fraction = final_x
            dFrac = int(this_fraction - prev_fraction)
            this_y = df.loc[index, 'NaCl_Conc']
            dY = this_y - prev_slope_y
            dY_per_frac = dY/dFrac
            dStop = dFrac
            stop = index
            slope_d = {prev_fraction + j: prev_slope_y+((j+1)*dY_per_frac)-(dY_per_frac/2) for j in range(dStop)}
            #print(slope_d)
            
            for j in range(prev_index, stop):
                conc_fraction = slope_d[df.loc[j,'fraction']]
                mol_rxn = frac_rxn_vol * conc_fraction
                tot_mol = mol_rxn + mol_buff
                #total_reaction_volume
                df.loc[j, 'rxn_mol'] = tot_mol/trv
                df.loc[j, 'fraction_conc'] = conc_fraction
        #now plot steps and other things
        if (index < len(df) -1) and df.loc[index, 'type'] == "step":
            print("we're on index {} and fraction {}.".format(index,df.loc[index, 'fraction'] ))
            df.loc[index, 'fraction_conc'] = df.loc[index, 'NaCl_Conc']
            #first plot the horizontal line
            if (index < len(df) -2):
                until = df.loc[index+1, 'fraction']-0.5
            elif (index == len(df) -2):
                until = df.loc[index, 'fraction']+0.5
            panel1.plot( [df.loc[index, 'fraction']-0.5, until], 
                         [df.loc[index, 'NaCl_Conc'], df.loc[index, 'NaCl_Conc']], 
                         color='r', linestyle='-', linewidth=2)
            #second plot the vertical line
            if (index < len(df) -2):
                panel1.plot( [df.loc[index+1, 'fraction']-0.5, df.loc[index+1, 'fraction']-0.5], 
                         [df.loc[index, 'NaCl_Conc'], df.loc[index+1, 'NaCl_Conc']], 
                         color='r', linestyle='-', linewidth=2)
        elif (df.loc[index, 'type'] == "slope"):
            if not pd.isnull(df.loc[index, 'NaCl_Conc']):
                if not slope_collecting:
                    prev_slope_x = df.loc[index, 'fraction']
                    prev_slope_y = df.loc[index, 'NaCl_Conc']
                    prev_index = index
                    #print("Index is ", index)
                    #print("  Prev slope x is ", prev_slope_x)
                    #print("  Prev slope y is ", prev_slope_y)
                    slope_collecting = True

if plot_rxn:     
    panel1.scatter(df['fraction'] + (bar_width/2) -0.5, df['rxn_mol'], 
                 color='#bc0f12', marker = 'x')
panel1.set_ylabel('NaCl Molarity', color='r')
panel1.tick_params('y', colors='r')

red_line = mlines.Line2D([], [], color='r', marker=None,
                          markersize=15, label='Gradient NaCl Molarity')
red_x = mlines.Line2D([], [], color='#bc0f12', marker='x', lw=0,
                          markersize=15, label='Assay NaCl Molarity')
blue_patch = mplpatches.Patch(color='#23807f', label="RLU({})".format(assay_time))
black_line = mlines.Line2D([], [], color='black', marker=None,
                          markersize=15, label="RLU before assay({})".format(neg_time))
if plot_legend:
    plt.legend(handles=[red_line, red_x, blue_patch, black_line], loc = "upper left",
               prop={'size': 8.5})
for outtype in ["png", "pdf"]:
    outname = "{}.{}".format(outpre, outtype)
    if outtype == "png":
        plt.savefig(outname, dpi=300)
    if outtype == "pdf":
        plt.savefig(outname)


